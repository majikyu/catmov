function catmov([parameter(mandatory=$true)][string]$movname, $out = $movname, $start, $end, $sep, $ext = "mp4", [switch]$copy, [switch]$alp, [int]$dig = 1){

#####error check 1

	if($alp){
		if($start -ne $null){
			if($start.Length -ne 1){
				echo '%%Error%%  -start:Cannot get String over 2 char'
				return
			}
			if([byte][char]"A" -gt [byte][char]$start -or [byte][char]"z" -lt [byte][char]$start){
				echo '%%Error%%  -start:Put only A to Z and a to z'
				return
			}
		}
		if($end -ne $null){
			if($end.Length -ne 1){
				echo '%%Error%%  -end:Cannot get String over 2 char'
				return
			}
			if([byte][char]"A" -gt [byte][char]$end -or [byte][char]"z" -lt [byte][char]$end){
				echo '%%Error%%  -end:Put only A to Z and a to z'
				return
			}
		}
	}
	
	if(!$alp){
		if($start -ne $null){
			if(0 -gt $end){
				echo '%%Error%%  -start:Put unsigned int'
				return
			}
		}if($end -ne $null){
			if(0 -gt $start){
				echo '%%Error%%  -end:Put unsigned int'
				return
			}
		}
	}
	
	if($alp -and $dig -ne 1){
		echo '%%Error%%  -alp and -dig cannot use simultaneously'
		return
	}

#####prepare variables

	if(Test-Path .catmanifest){rm .catmanifest -Force}
	if($alp){
		if($start -eq $null){$start=[byte][char]"A"}
		else{$start=[byte][char]$start}
	}else{
		if($start -eq $null){$start = 1}
	}
	if($alp -and $end -ne $null){$end = [byte][char]$end}
	$index = $start
	
	
#####count concat files

	$exist
	$filenum=0
	$filepath
	Do
	{
	if($alp){$filepath = $movname + $sep + [char]$index + "." + $ext}
	else{
		$digind = "{0:D" + $dig + "}"
		$strindex = $digind -f $index
		$filepath = $movname + $sep + $strindex + "." + $ext
		}
	$exist = Test-Path $filepath
		if($exist){
		echo "Found part fileÅy$filepathÅz"
		$filenum++
		$index++
		}		
	}
	while($exist -and ($end -eq $null -or $filenum -lt $end - $start + 1) )
	$index = $start
#####error check 2
	
	if($filenum -lt 2){
		echo "%%Error%%  cannot find over 2 videos"
		return
	}
	
	
#####make manifest file

	for($i=0;$i -lt $filenum;$i++){
	if($alp){$line = "file " + $movname + $sep + [char]$index + "." + $ext}
	else{
		$digind = "{0:D" + $dig + "}"
		$strindex = $digind -f $index
		$line = "file " + $movname + $sep + $strindex + "." + $ext
		}
	$line | Out-File .catmanifest -encoding default -append
	$index++
	}
	Set-ItemProperty -path ".\.catmanifest" -name Attributes -value "Hidden"


#####execute ffmpeg concat

	$outfilename = $out + "." + $ext
	echo "`n`n   Åy Cat $filenum videos =>=>=> $outfilename Åz`n`n"
	if($copy){
		ffmpeg -f concat -i .catmanifest -c copy -v quiet -stats $outfilename
	}else{
		ffmpeg -f concat -i .catmanifest -v quiet -stats $outfilename
	}
	rm .catmanifest -Force
	
}
