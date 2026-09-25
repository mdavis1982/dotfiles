# Go development
# -- Where Go installs binaries from 'go install'
export GOPATH=$HOME/Developer/Other/Go

# -- Add Go binaries to the path
export PATH=$PATH:$GOPATH/bin

# -- Enable Go modules
export GO111MODULE=on

# -- Set a module proxy for faster downloads
export GOPROXY=https://proxy.golang.org,direct
