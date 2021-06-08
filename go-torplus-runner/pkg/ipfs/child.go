package ipfs

type ChildProcessType int

const (
	Tor ChildProcessType = iota
	PaymentService
	IpfsService
)

type ChildProcess interface {
}
