package sms

import (
	// "net/url"
	//"net/http"
	//"strings"
	//"io/ioutil"
	"sync"
)

const (
	sendurl = "https://api.txtlocal.com/send"
)

type SMSRequest struct {
	Message string   `json:"message"`
	Numbers []string `json:"numbers"`
}
type SMSResponse struct {
	Response string `json:"response"`
	Number   string `json:"number"`
}

func sendSMS(smsreq SMSRequest) (response []SMSResponse) {
	var waitgroup sync.WaitGroup
	total := len(smsreq.Numbers)
	var numberOfGoRoutines int
	if total < 3 {
		numberOfGoRoutines = 0
	} else if total < 6 {
		numberOfGoRoutines = 1
	} else if total >= 6 && total < 9 {
		numberOfGoRoutines = 2
	} else {
		numberOfGoRoutines = 3
	}
	var chunkSize int
	if total <= 9 {
		chunkSize = 3
	} else {
		chunkSize = total / numberOfGoRoutines
	}
	mod := total % 3
	if mod != 0 {
		numberOfGoRoutines = numberOfGoRoutines + 1
	}
	respchannel := make(chan SMSResponse, numberOfGoRoutines)
	waitgroup.Add(numberOfGoRoutines)
	for k := 0; k < numberOfGoRoutines; k++ {
		if k != numberOfGoRoutines-1 {
			go send(smsreq.Numbers[k*chunkSize:k*chunkSize+chunkSize], smsreq.Message, respchannel, &waitgroup)
		} else {
			go send(smsreq.Numbers[chunkSize*k:], smsreq.Message, respchannel, &waitgroup)
		}
	}

	waitgroup.Wait()

	for j := 0; j < numberOfGoRoutines; j++ {
		resp := <-respchannel
		response = append(response, resp)
	}
	return
}

func send(msgReq []string, msg string, respchannel chan SMSResponse, waitgroup *sync.WaitGroup) {
	var mobileNo string
	for _, mobileNo = range msgReq {
		//var payload map[string]interface{}
		//client := &http.Client{}
		//smsResp := <-respchannel
		// form := url.Values{}
		// form.Add("apiKey", "gRdMgsFy72o-Vr5hjEa7o1oYEIjso74dGjXPnjcyvu")
		// form.Add("numbers", mobileNo)
		// form.Add("message", msg)
		// form.Add("sender", "TXTLCL")

		// req, err := http.NewRequest("POST", sendurl, strings.NewReader(form.Encode()))
		// req.Header.Add("Content-Type", "application/x-www-form-urlencoded")

		// response, err := client.Do(req)
		// if err != nil {
		// 	fmt.Println("error:",err)
		// }

		// content, err := ioutil.ReadAll(response.Body)
		// if err = json.Unmarshal(content, &payload); err != nil {
		//    fmt.Println("error:",err)
		// }

	}
	var smsResp SMSResponse
	smsResp.Response = "success"
	smsResp.Number = mobileNo
	respchannel <- smsResp

	waitgroup.Done()
}
