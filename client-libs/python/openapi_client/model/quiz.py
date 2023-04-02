# coding: utf-8

"""
    Emblem API

    REST API for any Emblem server  # noqa: E501

    The version of the OpenAPI document: 2021-09-01
    Generated by: https://openapi-generator.tech
"""

from datetime import date, datetime  # noqa: F401
import decimal  # noqa: F401
import functools  # noqa: F401
import io  # noqa: F401
import re  # noqa: F401
import typing  # noqa: F401
import typing_extensions  # noqa: F401
import uuid  # noqa: F401

import frozendict  # noqa: F401

from openapi_client import schemas  # noqa: F401


class Quiz(
    schemas.AnyTypeSchema,
):
    """NOTE: This class is auto generated by OpenAPI Generator.
    Ref: https://openapi-generator.tech

    Do not edit the class manually.
    """


    class MetaOapg:
        required = {
            "name",
        }
        
        class properties:
            
            
            class name(
                schemas.StrBase,
                schemas.NoneBase,
                schemas.Schema,
                schemas.NoneStrMixin
            ):
            
            
                def __new__(
                    cls,
                    *_args: typing.Union[None, str, ],
                    _configuration: typing.Optional[schemas.Configuration] = None,
                ) -> 'name':
                    return super().__new__(
                        cls,
                        *_args,
                        _configuration=_configuration,
                    )
            id = schemas.StrSchema
            host = schemas.StrSchema
            playUrl = schemas.StrSchema
            pin = schemas.StrSchema
            topic = schemas.StrSchema
            anonymous = schemas.BoolSchema
            imageUrl = schemas.StrSchema
            
            
            class difficulty(
                schemas.NumberSchema
            ):
            
            
                class MetaOapg:
                    inclusive_maximum = 10
                    inclusive_minimum = 1
            
            
            class timeLimit(
                schemas.NumberSchema
            ):
            
            
                class MetaOapg:
                    inclusive_maximum = 300
                    inclusive_minimum = 3
            numQuestions = schemas.StrSchema
            numAnswers = schemas.StrSchema
            
            
            class questions(
                schemas.ListSchema
            ):
            
            
                class MetaOapg:
                    
                    
                    class items(
                        schemas.DictSchema
                    ):
                    
                    
                        class MetaOapg:
                            required = {
                                "question",
                                "answers",
                            }
                            
                            class properties:
                                question = schemas.StrSchema
                                
                                
                                class answers(
                                    schemas.ListSchema
                                ):
                                
                                
                                    class MetaOapg:
                                        items = schemas.StrSchema
                                
                                    def __new__(
                                        cls,
                                        _arg: typing.Union[typing.Tuple[typing.Union[MetaOapg.items, str, ]], typing.List[typing.Union[MetaOapg.items, str, ]]],
                                        _configuration: typing.Optional[schemas.Configuration] = None,
                                    ) -> 'answers':
                                        return super().__new__(
                                            cls,
                                            _arg,
                                            _configuration=_configuration,
                                        )
                                
                                    def __getitem__(self, i: int) -> MetaOapg.items:
                                        return super().__getitem__(i)
                                __annotations__ = {
                                    "question": question,
                                    "answers": answers,
                                }
                        
                        question: MetaOapg.properties.question
                        answers: MetaOapg.properties.answers
                        
                        @typing.overload
                        def __getitem__(self, name: typing_extensions.Literal["question"]) -> MetaOapg.properties.question: ...
                        
                        @typing.overload
                        def __getitem__(self, name: typing_extensions.Literal["answers"]) -> MetaOapg.properties.answers: ...
                        
                        @typing.overload
                        def __getitem__(self, name: str) -> schemas.UnsetAnyTypeSchema: ...
                        
                        def __getitem__(self, name: typing.Union[typing_extensions.Literal["question", "answers", ], str]):
                            # dict_instance[name] accessor
                            return super().__getitem__(name)
                        
                        
                        @typing.overload
                        def get_item_oapg(self, name: typing_extensions.Literal["question"]) -> MetaOapg.properties.question: ...
                        
                        @typing.overload
                        def get_item_oapg(self, name: typing_extensions.Literal["answers"]) -> MetaOapg.properties.answers: ...
                        
                        @typing.overload
                        def get_item_oapg(self, name: str) -> typing.Union[schemas.UnsetAnyTypeSchema, schemas.Unset]: ...
                        
                        def get_item_oapg(self, name: typing.Union[typing_extensions.Literal["question", "answers", ], str]):
                            return super().get_item_oapg(name)
                        
                    
                        def __new__(
                            cls,
                            *_args: typing.Union[dict, frozendict.frozendict, ],
                            question: typing.Union[MetaOapg.properties.question, str, ],
                            answers: typing.Union[MetaOapg.properties.answers, list, tuple, ],
                            _configuration: typing.Optional[schemas.Configuration] = None,
                            **kwargs: typing.Union[schemas.AnyTypeSchema, dict, frozendict.frozendict, str, date, datetime, uuid.UUID, int, float, decimal.Decimal, None, list, tuple, bytes],
                        ) -> 'items':
                            return super().__new__(
                                cls,
                                *_args,
                                question=question,
                                answers=answers,
                                _configuration=_configuration,
                                **kwargs,
                            )
            
                def __new__(
                    cls,
                    _arg: typing.Union[typing.Tuple[typing.Union[MetaOapg.items, dict, frozendict.frozendict, ]], typing.List[typing.Union[MetaOapg.items, dict, frozendict.frozendict, ]]],
                    _configuration: typing.Optional[schemas.Configuration] = None,
                ) -> 'questions':
                    return super().__new__(
                        cls,
                        _arg,
                        _configuration=_configuration,
                    )
            
                def __getitem__(self, i: int) -> MetaOapg.items:
                    return super().__getitem__(i)
            sync = schemas.BoolSchema
            active = schemas.BoolSchema
            timeCreated = schemas.DateTimeSchema
            updated = schemas.DateTimeSchema
            selfLink = schemas.StrSchema
            __annotations__ = {
                "name": name,
                "id": id,
                "host": host,
                "playUrl": playUrl,
                "pin": pin,
                "topic": topic,
                "anonymous": anonymous,
                "imageUrl": imageUrl,
                "difficulty": difficulty,
                "timeLimit": timeLimit,
                "numQuestions": numQuestions,
                "numAnswers": numAnswers,
                "questions": questions,
                "sync": sync,
                "active": active,
                "timeCreated": timeCreated,
                "updated": updated,
                "selfLink": selfLink,
            }

    
    name: MetaOapg.properties.name
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["name"]) -> MetaOapg.properties.name: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["id"]) -> MetaOapg.properties.id: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["host"]) -> MetaOapg.properties.host: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["playUrl"]) -> MetaOapg.properties.playUrl: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["pin"]) -> MetaOapg.properties.pin: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["topic"]) -> MetaOapg.properties.topic: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["anonymous"]) -> MetaOapg.properties.anonymous: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["imageUrl"]) -> MetaOapg.properties.imageUrl: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["difficulty"]) -> MetaOapg.properties.difficulty: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["timeLimit"]) -> MetaOapg.properties.timeLimit: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["numQuestions"]) -> MetaOapg.properties.numQuestions: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["numAnswers"]) -> MetaOapg.properties.numAnswers: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["questions"]) -> MetaOapg.properties.questions: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["sync"]) -> MetaOapg.properties.sync: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["active"]) -> MetaOapg.properties.active: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["timeCreated"]) -> MetaOapg.properties.timeCreated: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["updated"]) -> MetaOapg.properties.updated: ...
    
    @typing.overload
    def __getitem__(self, name: typing_extensions.Literal["selfLink"]) -> MetaOapg.properties.selfLink: ...
    
    @typing.overload
    def __getitem__(self, name: str) -> schemas.UnsetAnyTypeSchema: ...
    
    def __getitem__(self, name: typing.Union[typing_extensions.Literal["name", "id", "host", "playUrl", "pin", "topic", "anonymous", "imageUrl", "difficulty", "timeLimit", "numQuestions", "numAnswers", "questions", "sync", "active", "timeCreated", "updated", "selfLink", ], str]):
        # dict_instance[name] accessor
        return super().__getitem__(name)
    
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["name"]) -> MetaOapg.properties.name: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["id"]) -> typing.Union[MetaOapg.properties.id, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["host"]) -> typing.Union[MetaOapg.properties.host, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["playUrl"]) -> typing.Union[MetaOapg.properties.playUrl, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["pin"]) -> typing.Union[MetaOapg.properties.pin, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["topic"]) -> typing.Union[MetaOapg.properties.topic, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["anonymous"]) -> typing.Union[MetaOapg.properties.anonymous, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["imageUrl"]) -> typing.Union[MetaOapg.properties.imageUrl, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["difficulty"]) -> typing.Union[MetaOapg.properties.difficulty, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["timeLimit"]) -> typing.Union[MetaOapg.properties.timeLimit, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["numQuestions"]) -> typing.Union[MetaOapg.properties.numQuestions, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["numAnswers"]) -> typing.Union[MetaOapg.properties.numAnswers, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["questions"]) -> typing.Union[MetaOapg.properties.questions, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["sync"]) -> typing.Union[MetaOapg.properties.sync, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["active"]) -> typing.Union[MetaOapg.properties.active, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["timeCreated"]) -> typing.Union[MetaOapg.properties.timeCreated, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["updated"]) -> typing.Union[MetaOapg.properties.updated, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: typing_extensions.Literal["selfLink"]) -> typing.Union[MetaOapg.properties.selfLink, schemas.Unset]: ...
    
    @typing.overload
    def get_item_oapg(self, name: str) -> typing.Union[schemas.UnsetAnyTypeSchema, schemas.Unset]: ...
    
    def get_item_oapg(self, name: typing.Union[typing_extensions.Literal["name", "id", "host", "playUrl", "pin", "topic", "anonymous", "imageUrl", "difficulty", "timeLimit", "numQuestions", "numAnswers", "questions", "sync", "active", "timeCreated", "updated", "selfLink", ], str]):
        return super().get_item_oapg(name)
    

    def __new__(
        cls,
        *_args: typing.Union[dict, frozendict.frozendict, str, date, datetime, uuid.UUID, int, float, decimal.Decimal, bool, None, list, tuple, bytes, io.FileIO, io.BufferedReader, ],
        name: typing.Union[MetaOapg.properties.name, None, str, ],
        id: typing.Union[MetaOapg.properties.id, str, schemas.Unset] = schemas.unset,
        host: typing.Union[MetaOapg.properties.host, str, schemas.Unset] = schemas.unset,
        playUrl: typing.Union[MetaOapg.properties.playUrl, str, schemas.Unset] = schemas.unset,
        pin: typing.Union[MetaOapg.properties.pin, str, schemas.Unset] = schemas.unset,
        topic: typing.Union[MetaOapg.properties.topic, str, schemas.Unset] = schemas.unset,
        anonymous: typing.Union[MetaOapg.properties.anonymous, bool, schemas.Unset] = schemas.unset,
        imageUrl: typing.Union[MetaOapg.properties.imageUrl, str, schemas.Unset] = schemas.unset,
        difficulty: typing.Union[MetaOapg.properties.difficulty, decimal.Decimal, int, float, schemas.Unset] = schemas.unset,
        timeLimit: typing.Union[MetaOapg.properties.timeLimit, decimal.Decimal, int, float, schemas.Unset] = schemas.unset,
        numQuestions: typing.Union[MetaOapg.properties.numQuestions, str, schemas.Unset] = schemas.unset,
        numAnswers: typing.Union[MetaOapg.properties.numAnswers, str, schemas.Unset] = schemas.unset,
        questions: typing.Union[MetaOapg.properties.questions, list, tuple, schemas.Unset] = schemas.unset,
        sync: typing.Union[MetaOapg.properties.sync, bool, schemas.Unset] = schemas.unset,
        active: typing.Union[MetaOapg.properties.active, bool, schemas.Unset] = schemas.unset,
        timeCreated: typing.Union[MetaOapg.properties.timeCreated, str, datetime, schemas.Unset] = schemas.unset,
        updated: typing.Union[MetaOapg.properties.updated, str, datetime, schemas.Unset] = schemas.unset,
        selfLink: typing.Union[MetaOapg.properties.selfLink, str, schemas.Unset] = schemas.unset,
        _configuration: typing.Optional[schemas.Configuration] = None,
        **kwargs: typing.Union[schemas.AnyTypeSchema, dict, frozendict.frozendict, str, date, datetime, uuid.UUID, int, float, decimal.Decimal, None, list, tuple, bytes],
    ) -> 'Quiz':
        return super().__new__(
            cls,
            *_args,
            name=name,
            id=id,
            host=host,
            playUrl=playUrl,
            pin=pin,
            topic=topic,
            anonymous=anonymous,
            imageUrl=imageUrl,
            difficulty=difficulty,
            timeLimit=timeLimit,
            numQuestions=numQuestions,
            numAnswers=numAnswers,
            questions=questions,
            sync=sync,
            active=active,
            timeCreated=timeCreated,
            updated=updated,
            selfLink=selfLink,
            _configuration=_configuration,
            **kwargs,
        )
