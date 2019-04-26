package server

import (	
	"net/http"
	"github.com/gorilla/mux"
	api "github.com/tanya-saroha/absentee/sms_service/api"
	"github.com/tanya-saroha/absentee/sms_service/sms"
	)
	const (
		versionHeader = "Accept"
	)

func initRouter() (router *mux.Router) {
	v1:="absentee"
	router = mux.NewRouter()
	absenteerouter := router.PathPrefix("/absentee").Subrouter()
	absenteerouter.HandleFunc("/ping", pingHandler).Methods(http.MethodGet)
	absenteerouter.HandleFunc("/sms", sms.SendSMS()).Methods(http.MethodPost).Headers(versionHeader, v1)
	return
}
func pingHandler(rw http.ResponseWriter, req *http.Request) {
	api.Success( http.StatusOK, api.Response{Message: "pong"},rw)
}
