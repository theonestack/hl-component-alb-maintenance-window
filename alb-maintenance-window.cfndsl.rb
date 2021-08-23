CloudFormation do

  export      = external_parameters.fetch(:export_name, external_parameters[:component_name])
  path        = external_parameters.fetch(:path, false)
  host        = external_parameters.fetch(:host, false)
  priority    = external_parameters.fetch(:priority, 1)
  error       = external_parameters.fetch(:error)
  status_code = external_parameters.fetch(:status_code)
  name        = external_parameters.fetch(:name, "MaintenanceWindowRule#{priority}")
  title       = external_parameters.fetch(:title)
  message     = external_parameters.fetch(:message)
  body        = external_parameters.fetch(:body, {
    'code': status_code,
    'error': error,
    'title': title,
    'message': message,
    'expires': '${ExpireDate}'
  })

  conditions = []

  if path
    conditions << { Field: "path-pattern", Values: [ path ].flatten() }
  end

  if host
    hosts = []
    if host.include?('!DNSDomain')
      host_subdomain = host.gsub('!DNSDomain', '') #remove <DNSDomain>
      hosts << FnJoin("", [ host_subdomain , Ref('DnsDomain') ])
    elsif host.include?('.')
      hosts << host
    else
      hosts << FnJoin("", [ host, ".", Ref('DnsDomain') ])
    end
    conditions << { Field: "host-header", Values: hosts }
  end

  if conditions.length() == 0
    raise "At least one condition (path or host) must be defined."
  end

  actions = [
    {
      'Type': 'fixed-response',
      'FixedResponseConfig': {
        'MessageBody': FnSub(body.to_json),
        'StatusCode': '503',
        'ContentType': 'application/json'
      }
    }
  ]

  ElasticLoadBalancingV2_ListenerRule(name) do
    Actions actions
    Conditions conditions
    ListenerArn Ref('ListenerARN')
    Priority priority
  end

  Output(:Rule) do
    Value(Ref(name))
    Export FnSub("${EnvironmentName}-#{name}")
  end

end