# alb-maintenance-window CfHighlander component

Deploys a custom Rule into a given Application Load Balancer Listener

```bash
kurgan add alb-maintenance-window
```

## Requirements

## Parameters

| Name | Use | Default | Global | Type | Allowed Values |
| ---- | --- | ------- | ------ | ---- | -------------- |
| EnvironmentName | Tagging | dev | true | string
| EnvironmentType | Tagging | development | true | string | ['development','production']
| ListenerARN | The ARN of Listener | None | string

## Configuration

Default configs [here](./alb-maintenance-window.config.yaml)

```yaml
path: '/' # Required if host is not specified
host: '*.*' # Required if path is not specified

status_code: 503

content_type: application/json # Valid Values: text/plain | text/css | text/html | application/javascript | application/json
body: |- # Body is inside a FnSub
  {
    "code": "${StatusCode}",
    "error": temporarily_unavailable,
    "title": Planned Maintenance,
    "message": We are currently undergoing planned maintenance.,
    "expires": "${ExpireDate}"
  }
```

## Outputs/Exports

| Name | Value | Exported |
| ---- | ----- | -------- |
| MaintenanceWindowRule# | Application Load Balancer Listener's Rule | true

## Included Components

## Development

```bash
gem install cfhighlander
```

or via docker

```bash
docker pull theonestack/cfhighlander
```

compiling the templates

```bash
cfcompile alb-maintenance-window
```

compiling with the vaildate flag to validate the templates

```bash
cfcompile alb-maintenance-window --validate
```

### Testing

```bash
gem install rspec
```

```bash
rspec

.........
  ============================
  #    CfHighlander Tests    #
  ============================

  Pass: 1
  Fail: 0
  Time: 1.596713

....

Finished in 14.28 seconds (files took 0.20268 seconds to load)
11 examples, 0 failures
```


