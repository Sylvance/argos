package argosapi

import (
	argos "argos/gen/argos"
	"context"

	"goa.design/clue/log"
)

// argos service example implementation.
// The example methods log the requests and return zero values.
type argossrvc struct{}

// NewArgos returns the argos service implementation.
func NewArgos() argos.Service {
	return &argossrvc{}
}

// Multiply implements multiply.
func (s *argossrvc) Multiply(ctx context.Context, p *argos.MultiplyPayload) (res int, err error) {
	log.Printf(ctx, "argos.multiply")
	return p.A * p.B, nil
}
