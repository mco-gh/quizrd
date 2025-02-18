# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
import uuid

from google.cloud import firestore
from resources.base import canonical_resource, etag, snapshot_to_resource


client = firestore.Client()

collection_name_prefix = ""
db_environment = os.environ.get("QUIZAIC_DB_ENVIRONMENT", None)
if db_environment == "TEST":
    collection_name_prefix = str(uuid.uuid4())


def list(resource_kind, resource_fields):
    resource_collection = client.collection(collection_name_prefix + resource_kind)
    representations_list = []
    for resource_ref in resource_collection.stream():
        resource = snapshot_to_resource(resource_ref)
        representations_list.append(
            canonical_resource(resource, resource_kind, resource_fields)
        )

    return representations_list


def list_matching(resource_kind, resource_fields, field_name, value):
    resource_collection = client.collection(collection_name_prefix + resource_kind)
    query = resource_collection.where(field_name, "==", value)

    representations_list = []
    for resource_ref in query.stream():
        resource = snapshot_to_resource(resource_ref)
        representations_list.append(
            canonical_resource(resource, resource_kind, resource_fields)
        )

    return representations_list


def fetch(resource_kind, id, resource_fields):
    resource_reference = client.document(
        "{}/{}".format(collection_name_prefix + resource_kind, id)
    )
    snapshot = resource_reference.get()
    if not snapshot.exists:
        return None

    resource = canonical_resource(
        snapshot_to_resource(snapshot), resource_kind, resource_fields
    )

    return resource


def insert(resource_kind, representation, resource_fields, host_url=None):
    resource = {"kind": resource_kind}
    for field in resource_fields:
        resource[field] = representation.get(field, None)

    id = representation.get("id", None)
    doc_ref = client.collection(collection_name_prefix + resource_kind).document(id)
    doc_ref.set(resource)

    if host_url is not None:
        resource = canonical_resource(
            snapshot_to_resource(doc_ref.get()),
            resource_kind,
            resource_fields,
            host_url=host_url,
        )
    else:
        resource = canonical_resource(
            snapshot_to_resource(doc_ref.get()), resource_kind, resource_fields
        )

    return resource


def update(resource_kind, id, representation, resource_fields, match_etag):
    transaction = client.transaction()
    resource_reference = client.document(
        "{}/{}".format(collection_name_prefix + resource_kind, id)
    )

    @firestore.transactional
    def update_in_transaction(transaction, resource_reference, representation):
        resource_snapshot = resource_reference.get(transaction=transaction)
        if not resource_snapshot.exists:
            return None, 404

        resource = canonical_resource(
            snapshot_to_resource(resource_snapshot), resource_kind, resource_fields
        )

        if match_etag is not None:  # Only apply if resource has not changed
            if match_etag != etag(resource):
                return None, 409

        transaction.update(resource_reference, representation)

        for key in representation:
            if key in resource:
                resource[key] = representation[key]

        return resource, 200

    return update_in_transaction(transaction, resource_reference, representation)


def delete(resource_kind, id, resource_fields, match_etag, host_url=None):
    resource_reference = client.document(
        "{}/{}".format(collection_name_prefix + resource_kind, id)
    )
    resource_snapshot = resource_reference.get()
    if not resource_snapshot.exists:
        return 404

    resource = canonical_resource(
        snapshot_to_resource(resource_snapshot),
        resource_kind,
        resource_fields,
        host_url,
    )

    if match_etag is not None:  # Only apply if resource has not changed
        if match_etag != etag(resource):
            return 409

    resource_reference.delete()
    return 204
