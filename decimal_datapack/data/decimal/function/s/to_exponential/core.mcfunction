# arguments(template): $(mFirstDigit) $(mRPadLeft) $(mRDigits) $(mRPadRight) $(e)
# output (storage): decimal:out to_exponential

#example: {mFirstDigit:9,mRPadLeft:"",mRDigits:12345678,mRPadRight:"",e:123} 9.12345678e123

$data modify storage decimal:out to_exponential set value "$(mFirstDigit).$(mRPadLeft)$(mRDigits)$(mRPadRight)e$(e)"

