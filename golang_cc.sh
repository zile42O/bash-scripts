#!/usr/bin/env bash
#PROGRAM_VAR_DEFINE (used by me for defining arch by runtime if you don't need it remove it)
package=$1
if [[ -z "$package" ]]; then
  echo "usage: $0 <package-name>"
  exit 1
fi
package_split=(${package//\// })
package_name=${package_split[-1]}
	
platforms=(
	"linux/arc" "aix/ppc64" "android/386" "android/amd64" "android/arm" "android/arm64" "darwin/amd64" "darwin/arm64" "dragonfly/amd64" "freebsd/386" "freebsd/amd64" "freebsd/arm" "freebsd/arm64" "illumos/amd64" "ios/amd64" "ios/arm64" "js/wasm" "linux/386" "linux/amd64" "linux/arm" "linux/arm64" "linux/mips" "linux/mips64" "linux/mips64le" "linux/mipsle" "linux/ppc64" "linux/ppc64le" "linux/riscv64" "linux/s390x" "netbsd/386" "netbsd/amd64" "netbsd/arm" "netbsd/arm64" "openbsd/386" "openbsd/amd64" "openbsd/arm" "openbsd/arm64" "openbsd/mips64" "plan9/386" "plan9/amd64" "plan9/arm" "solaris/amd64" "windows/386" "windows/amd64" "windows/arm" "windows/arm64"
)

for platform in "${platforms[@]}"
do
	platform_split=(${platform//\// })
	GOOS=${platform_split[0]}
	GOARCH=${platform_split[1]}
	output_name=$package_name'-'$GOOS'.'$GOARCH
	if [ $GOOS = "windows" ]; then
		output_name+='.exe'
		env GOOS=$GOOS GOARCH=$GOARCH go build -ldflags="-s -w -H windowsgui -X 'main.Architecture=$GOOS/$GOARCH' -extldflags '-static'" -o bins/$output_name *.go 
	elif [ $GOARCH = "arm" ]; then
		output_name=$package_name'-'$GOOS'.'$GOARCH
		PROGRAM_VAR_DEFINE=$GOOS'/'$GOARCH
		env GOOS=$GOOS GOARCH=$GOARCH go build -ldflags="-s -w -X 'main.Architecture=$PROGRAM_VAR_DEFINE' -extldflags '-static'" -o bins/$output_name *.go
		output_name=$package_name'-'$GOOS'.'$GOARCH'5'
		PROGRAM_VAR_DEFINE=$GOOS'/'$GOARCH'5'
		env GOOS=$GOOS GOARCH=$GOARCH GOARM=5 go build -ldflags="-s -w -X 'main.Architecture=$PROGRAM_VAR_DEFINE' -extldflags '-static'" -o bins/$output_name *.go
		output_name=$package_name'-'$GOOS'.'$GOARCH'6'
		PROGRAM_VAR_DEFINE=$GOOS'/'$GOARCH'6'
		env GOOS=$GOOS GOARCH=$GOARCH GOARM=6 go build -ldflags="-s -w -X 'main.Architecture=$PROGRAM_VAR_DEFINE' -extldflags '-static'" -o bins/$output_name *.go
		output_name=$package_name'-'$GOOS'.'$GOARCH'7'
		PROGRAM_VAR_DEFINE=$GOOS'/'$GOARCH'7'
		env GOOS=$GOOS GOARCH=$GOARCH GOARM=7 go build -ldflags="-s -w -X 'main.Architecture=$PROGRAM_VAR_DEFINE' -extldflags '-static'" -o bins/$output_name *.go
	else
		env GOOS=$GOOS GOARCH=$GOARCH go build -ldflags="-s -w -X 'main.Architecture=$GOOS/$GOARCH' -extldflags '-static'" -o bins/$output_name *.go
	fi
	echo "Compiling on dist: $output_name"
	if [ $? -ne 0 ]; then
		echo "An error has occurred! Skipping $output_name"
		#exit 1
	fi
done
