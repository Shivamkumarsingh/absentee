package sms

import (
	api "github.com/tanya-saroha/absentee/sms_service/api"
	"net/http"
)

func SendSMS() http.HandlerFunc {
	return http.HandlerFunc(func(rw http.ResponseWriter, req *http.Request) {
		err:=sendSMS(req.Context())	
		println("err",err)
		api.Success(http.StatusCreated, api.CreateResponse{Message: "send successfully", ID: "1234567890"}, rw)
	})
}
