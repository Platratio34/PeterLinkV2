adr=property.getNumber("Adr")
tT=10
function onTick()
    r0V={}
    r0X=input.getBool(1)
    r0A=input.getNumber(1)
    r0C=input.getNumber(2)
    r0O=input.getNumber(3)
    for i=1,10 do
        r0V[i]= input.getNumber(3+i)
    end
    r1V={}
    r1X=input.getBool(14)
    r1A=input.getNumber(14)
    r1C=input.getNumber(15)
    r1O=input.getNumber(16)
    for i=1,10 do
        r1V[i]= input.getNumber(16+i)
    end
    
    if(r0X and r0A>1000) then
        r0O=(adr/1000)+r0O
        output.setBool(14,true)
        output.setNumber(14,r0A)
        output.setNumber(15,r0C)
        output.setNumber(16,r0O)
        for i=1,10 do
            output.setNumber(16+i,r0V[i])
        end
    else
        output.setBool(14,false)
        output.setNumber(14,0)
        output.setNumber(15,0)
        output.setNumber(16,0)
        for i=1,10 do
            output.setNumber(16+i,0)
        end
    end
    if(r1X and r1A>(adr*1000) and r1A<(adr*1000+1000)) then
        r1A=r1A-(adr*1000)
        output.setBool(1,true)
        output.setNumber(1,r1A)
        output.setNumber(2,r1C)
        output.setNumber(3,r1O)
        for i=1,10 do
            output.setNumber(3+i,r1V[i])
        end
    else
        output.setBool(1,false)
        output.setNumber(1,0)
        output.setNumber(2,0)
        output.setNumber(3,0)
        for i=1,10 do
            output.setNumber(3+i,0)
        end
    end
    if(r0X and r0A==1000) then
        if(r0C==1) then
	    if(r0V[1]<1000 and r0V[1]>0) then adr=r0V[1] end
        elseif(r0C==101) then
		tT=10
		output.setBool(1,true)
		output.setNumber(1,r0O)
		output.setNumber(2,201)
		output.setNumber(3,100)
		output.setNumber(4,adr)
        end
    end
	tT=tT-1
	if(tT==0) then
		output.setBool(1,false)
		output.setNumber(1,0)
		output.setNumber(2,0)
		output.setNumber(3,0)
		output.setNumber(4,0)
	end
end
