# Get the Kernel Name
Kernel=$(uname -s)
case "$Kernel" in
	Linux)			Kernel="linux";;
	Darwin)			Kernel="darwin";;
	Windows)		Kernel="windows";;
	Android)		Kernel="android";;
	FreeBSD)		Kernel="freebsd";;
	Dragonfly)		Kernel="dragonfly";;
	Solaris)		Kernel="solaris";;
* ) echo "Your Operating System -> ITS NOT SUPPORTED"   ;;
esac

echo
echo "Operating System Kernel : $Kernel"
echo
# Get the machine Architecture
Architecture=$(uname -m)
case "$Architecture" in
	x86)			Architecture="x86";;
	ia64)			Architecture="ia64";;
	i?86)			Architecture="x86";;
	amd64)			Architecture="amd64";;
	x86_64)			Architecture="x86_64";;
	sparc64)		Architecture="sparc64";;
	i386)			Architecture="i386";;
	arm64)			Architecture="arm64";;
	arm7)			Architecture="arm7";;
	armc)			Architecture="armc";;
	386)			Architecture="386";;
	mips)			Architecture="mips";;
	mipsle)			Architecture="mipsle";;
	mips64)			Architecture="mips64";;
	mips64le)		Architecture="mips64le";;
	ppc64)			Architecture="ppc64";;
	ppc64le)		Architecture="ppc64le";;
	s390x)			Architecture="s390x";;
	riscv64)		Architecture="riscv64";;
* ) echo "Your Architecture '$Architecture' -> ITS NOT SUPPORTED."   ;;
esac

echo
echo "Operating System Architecture : $Architecture"
echo
