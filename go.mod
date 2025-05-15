module github.com/lukedirtwalker/frr_reproducer

go 1.23.6

require github.com/osrg/gobgp/v4 v4.0.0-20250515054053-fb8744426a89

require (
	github.com/spf13/cobra v1.9.1
	github.com/vishvananda/netlink v1.3.1
	go4.org/netipx v0.0.0-20231129151722-fdeea329fbba
)

require (
	github.com/inconshreveable/mousetrap v1.1.0 // indirect
	github.com/sirupsen/logrus v1.9.3 // indirect
	github.com/spf13/pflag v1.0.6 // indirect
	github.com/vishvananda/netns v0.0.5 // indirect
	golang.org/x/sys v0.33.0 // indirect
)

replace github.com/osrg/gobgp/v4 => ./gobgp
