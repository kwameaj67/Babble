// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: google/api/label.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

#import <stdatomic.h>

#import "google/api/Label.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - LabelRoot

@implementation LabelRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - LabelRoot_FileDescriptor

static GPBFileDescriptor *LabelRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"google.api"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - LabelDescriptor

@implementation LabelDescriptor

@dynamic key;
@dynamic valueType;
@dynamic description_p;

typedef struct LabelDescriptor__storage_ {
  uint32_t _has_storage_[1];
  LabelDescriptor_ValueType valueType;
  NSString *key;
  NSString *description_p;
} LabelDescriptor__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "key",
        .dataTypeSpecific.className = NULL,
        .number = LabelDescriptor_FieldNumber_Key,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(LabelDescriptor__storage_, key),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "valueType",
        .dataTypeSpecific.enumDescFunc = LabelDescriptor_ValueType_EnumDescriptor,
        .number = LabelDescriptor_FieldNumber_ValueType,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(LabelDescriptor__storage_, valueType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "description_p",
        .dataTypeSpecific.className = NULL,
        .number = LabelDescriptor_FieldNumber_Description_p,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(LabelDescriptor__storage_, description_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[LabelDescriptor class]
                                     rootClass:[LabelRoot class]
                                          file:LabelRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(LabelDescriptor__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t LabelDescriptor_ValueType_RawValue(LabelDescriptor *message) {
  GPBDescriptor *descriptor = [LabelDescriptor descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:LabelDescriptor_FieldNumber_ValueType];
  return GPBGetMessageInt32Field(message, field);
}

void SetLabelDescriptor_ValueType_RawValue(LabelDescriptor *message, int32_t value) {
  GPBDescriptor *descriptor = [LabelDescriptor descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:LabelDescriptor_FieldNumber_ValueType];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Enum LabelDescriptor_ValueType

GPBEnumDescriptor *LabelDescriptor_ValueType_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "String\000Bool\000Int64\000";
    static const int32_t values[] = {
        LabelDescriptor_ValueType_String,
        LabelDescriptor_ValueType_Bool,
        LabelDescriptor_ValueType_Int64,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(LabelDescriptor_ValueType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:LabelDescriptor_ValueType_IsValidValue];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
//      [worker release];
      [worker release];
    }
  }
  return descriptor;
}

BOOL LabelDescriptor_ValueType_IsValidValue(int32_t value__) {
  switch (value__) {
    case LabelDescriptor_ValueType_String:
    case LabelDescriptor_ValueType_Bool:
    case LabelDescriptor_ValueType_Int64:
      return YES;
    default:
      return NO;
  }
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
