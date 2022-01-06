address=101
cC,cO=0
cV={0,0,0,0,0,0,0,0,0,0}
msg,msgO=""
thX=false
thA,thC=0
thV={0,0,0,0,0,0,0,0,0,0}
tT,mT=0
function onTick()
    if(address==0) then
        address=property.getNumber("Adr")
    end
    if(msgO==msg) then
        mT=mT+1
        if(mT>=240) then
            msg=""
        else
            msgO=msg
        end
    end
    rV={}
    rX=input.getBool(1) -- ant
    rA=rnd(input.getNumber(1)) -- ant
    rC=input.getNumber(2) -- ant
    rO=input.getNumber(3) -- ant
    for i=1,10 do
    	rV[i]=input.getNumber(3+i) -- ant
    end
    tX=input.getBool(14) -- local
    if(rX and rA==address) then
        if(rC>0) then
            if(cC==0) then
                cC=rC
                cV=rV
                cO=rO
                if(cC>100 and cC<=200) then
                    msg="Received GET type command"
                elseif(cC>0 and cC<=100) then
                    msg="Received SET type command"
                elseif(cC>200 and cC<=300) then
                    msg="Received return on GET"
                end
            end
        elseif(rC<0) then
            if(cC<bebeb0) then
                msg="Command cleared by remote"
                cC=0
                cV={0,0,0,0,0,0,0,0,0,0}
                cO=0
            end
        else
            msg="Received bad command"
        end
    end
    if(tX and cC>0) then
        msg="Command cleared by local"
        cC=0
        cV={0,0,0,0,0,0,0,0,0,0}
        cO=0
    end

    if(tX) then
        msg="Received local transmit"
        thX=true
        thA=input.getNumber(14) -- local
        thC=input.getNumber(15) -- local
    	for i=1,10 do
            thV[i]=input.getNumber(15+i) -- local
    	end
    end
    if(thX and thA<0) then
        if(thC==1) then
            if(thV[1]>100 and thV[1]<1000) then
            	address=thV[1]
                msg="Setting Address"
            else
                msg="Invalid Address"
            end
        elseif(thC==101) then
            cC=201
            cV={address,0,0,0,0,0,0,0,0,0}
            cO=-1
            msg="Returning address"
        elseif(thC==0) then
            msg="Local clear"
        end
        thX=false
        thA=0
        thC=0
        thV={0,0,0,0,0,0,0,0,0,0}
    end
    
    if(not rX and thX) then
        output.setBool(1,true)
        tT=tT+1
    else
        output.setBool(1,false)
        tT=0
    end
    output.setNumber(1,thA) -- ant
    output.setNumber(2,thC) -- ant
    output.setNumber(3,address) -- ant
    for i=1,10 do
    	output.setNumber(3+i,thV[i]) -- ant
    end

    output.setNumber(14,cC) -- local
    output.setNumber(15,cO) -- local
    for i=1,10 do
    	output.setNumber(15+i,cV[i]) -- local
    end
    
    if(tT>=10) then
        thX=false
        thA=0
        thC=0
        thV={0,0,0,0,0,0,0,0,0,0}
        tT=0
        msg="Finished transmit"
    end
end

function onDraw()
    w=screen.getWidth()
    h=screen.getHeight()
    screen.drawText(10,1,"Address: " .. address)
    if(cC>0) then
        screen.drawText(10,10,"Current Command: "..cC)
        screen.drawText(10,20,"Current Origin: "..cO)
        screen.drawText(10,30,"Current Value:")
        screen.drawText(10,40,cV[1]..","..cV[2]..","..cV[3]..","..cV[4]..","..cV[5])
        screen.drawText(10,50,cV[6]..","..cV[7]..","..cV[8]..","..cV[9]..","..cV[10])
    else
        screen.drawText(10,10,"Current Command:")
        screen.drawText(10,20,"Current Origin:")
        screen.drawText(10,30,"Current Value:")
    end
    screen.drawText(10,h-10,msg)
end

function rnd(n)
    return math.floor(n+0.5)
end
