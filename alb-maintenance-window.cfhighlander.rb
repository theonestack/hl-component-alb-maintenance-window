CfhighlanderTemplate do
  Name 'alb-maintenance-window'

  Parameters do
    ComponentParam 'EnvironmentName'
    ComponentParam 'EnvironmentVersion'
    ComponentParam 'ListenerARN'
  end

end