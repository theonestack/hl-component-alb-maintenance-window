CfhighlanderTemplate do
  Name 'alb-maintenance-window'

  Parameters do
    ComponentParam 'EnvironmentName', 'dev', isGlobal: true
    ComponentParam 'EnvironmentType', 'development', isGlobal: true
    ComponentParam 'ListenerARN'
  end

end