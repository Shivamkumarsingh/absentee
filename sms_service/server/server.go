package server

import (
	"fmt"
	"strconv"
	"github.com/rs/cors"
	"github.com/urfave/negroni"
)

func StartAPIServer() {
	port := 8000
	c := cors.Default()
	server := negroni.Classic()
	server.Use(c)

	router := initRouter()
	server.UseHandler(router)

	addr := fmt.Sprintf(":%s", strconv.Itoa(port))
	server.Run(addr)
}