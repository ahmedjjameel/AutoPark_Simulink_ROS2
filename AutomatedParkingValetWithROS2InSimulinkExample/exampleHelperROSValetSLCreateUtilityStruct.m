function varargout = exampleHelperROSValetSLCreateUtilityStruct(obj)

%exampleHelperROSValetSLCreateUtilityBus create struct from object.

if isa(obj, 'vehicleDimensions')
    
    vehicleDimsStruct            = struct;
    vehicleDimsStruct            = exampleHelperROSValetMatchStructFields(vehicleDimsStruct, obj);
    vehicleDimsStruct.WorldUnits = uint8(vehicleDimsStruct.WorldUnits);
    varargout{1}                  = vehicleDimsStruct;
    
elseif isa(obj, 'vehicleCostmap')
    
    costmapStruct                   = struct;
    costmapStruct                   = exampleHelperROSValetMatchStructFields(costmapStruct, obj);
    costmapStruct                   = rmfield(costmapStruct, 'CollisionChecker');
    costmapStruct.InflationRadius   = obj.CollisionChecker.InflationRadius;
    costmapStruct.Costs             = getCosts(obj);
    
    vehicleDimsStruct               = struct;
    vehicleDimsStruct               = exampleHelperROSValetMatchStructFields(vehicleDimsStruct, obj.CollisionChecker.VehicleDimensions);
    vehicleDimsStruct.WorldUnits    = uint8(vehicleDimsStruct.WorldUnits);
    varargout{1}                     = vehicleDimsStruct;
    varargout{2}                     = costmapStruct;
    
else
    error('Invalid obj data type.');
end


