package sms

import (
	"context"
	"go.uber.org/zap"	
)

func sendSMS(ctx context.Context) error{
   sugar := zap.NewExample().Sugar()
	sugar.Infof("inside sms service")
    return nil
}

