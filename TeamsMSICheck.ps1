#working folder
$folder = "c:\teamsVDI\"

#get latest version
#confirm download link at https://docs.microsoft.com/en-us/microsoftteams/msi-deployment
$source = "https://teams.microsoft.com/downloads/desktopurl?env=production&plat=windows&arch=x64&managedInstaller=true&download=true"
$req = [System.Net.WebRequest]::Create($source)
$resp = $req.GetResponse()
$newTeamsVersion = $resp.ResponseUri.Segments[2]
$newTeamsVersion = $newTeamsVersion -replace '/','.msi'


if (-not(Test-Path -Path $folder$newTeamsVersion -PathType Leaf)){

write-output "Downloading File " $folder$newTeamsVersion
$destination = $folder +$newTeamsVersion + ".msi"
$filedetail = Invoke-WebRequest -Uri $source -OutFile $destination
}else{
$date = get-date -Format "MM/dd/yyyy" 
$date +"`t" + $newTeamsVersion  |Out-File -FilePath $folder"TeamsMSICheck.txt" -Append
}
