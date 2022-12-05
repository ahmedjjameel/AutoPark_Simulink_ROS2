function toObj = exampleHelperROSValetMatchStructFields(toObj, fromObj)

%exampleHelperROSValetMatchStructFields assign field values for structs/objects.

% Copyright 2019 The MathWorks, Inc.

fieldNames = fields(fromObj);
for n = 1 : numel(fieldNames)
    toObj.(fieldNames{n}) = fromObj.(fieldNames{n});
end
end