package sms

import (
	
	"errors"
	json "encoding/json"
	api "github.com/tanya-saroha/absentee/sms_service/api"
	"net/http"
)

func SendSMS() http.HandlerFunc {
	return http.HandlerFunc(func(rw http.ResponseWriter, req *http.Request) {
		
		var request SMSRequest
		err := json.NewDecoder(req.Body).Decode(&request)
		if err != nil {
			err = errors.New("json format error")
			api.Error(http.StatusBadRequest, api.Response{Message: err.Error()}, rw)
			return
		}
		response:=sendSMS(request)	
		
		api.Success(http.StatusCreated, response, rw)
	})
}
