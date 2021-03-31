module github.com/yomorun/yomo-source-mqtt-starter-test

go 1.15

require (
	github.com/yomorun/yomo-source-mqtt-broker-starter v0.6.0
	github.com/yomorun/yomo-source-mqtt-starter v0.3.0
	github.com/yomorun/yomo v1.0.0
)

replace (
	github.com/yomorun/yomo v1.0.0 => ../yomo
)
