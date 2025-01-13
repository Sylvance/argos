package design

import (
	. "goa.design/goa/v3/dsl"
)

var _ = API("argos", func() {
	Title("Argos Calculator Service")
	Description("Service for multiplying numbers, a Goa teaser")
	Version("1.0")
	Server("argos", func() {
		Host("localhost", func() {
			URI("http://localhost:8000")
			URI("grpc://localhost:8080")
		})
	})
})

var _ = Service("argos", func() {
	Description("The argos service performs operations on numbers.")

	Method("multiply", func() {
		Payload(func() {
			Field(1, "a", Int, "Left operand")
			Field(2, "b", Int, "Right operand")
			Required("a", "b")
		})

		Result(Int)

		HTTP(func() {
			GET("/multiply/{a}/{b}")
		})

		GRPC(func() {
		})
	})

	Files("/openapi.json", "./gen/http/openapi.json")
})
