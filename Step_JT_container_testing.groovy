def StageForContainer(String buildDir, String stageDir)
{
	echo "Executing StageForContainer..."
	script{		
		def unitFullPath="${buildDir}"
		def stagePath="${stageDir}"
		
		sh "chmod +x ./shellScripts/StageForContainer.sh "
		sh "./shellScripts/StageForContainer.sh ${unitFullPath} ${stagePath} "		
	}
}

def CheckLicenseServer()
{
	echo "Executing CheckLicenseServer..."
	script{
		sh "chmod +x ./shellScripts/CheckLicenseServer.sh "
		sh "./shellScripts/CheckLicenseServer.sh"		
	}
}

def RemoveRunningContainers()
{
	echo "Executing RemoveRunningContainers..."
	script{
		sh "chmod +x ./shellScripts/RemoveRunningContainers.sh "
		sh "./shellScripts/RemoveRunningContainers.sh"		
	}
}

def BuildAndRunDocker(String buildDir, String stageDir)
{
	echo "Executing BuildAndRunDocker..."
	script{		
		def unitFullPath="${buildDir}"
		def stagePath="${stageDir}"
		
		sh "chmod +x ./shellScripts/BuildAndRunDocker.sh "
		sh "./shellScripts/BuildAndRunDocker.sh ${unitFullPath} ${stagePath}"		
	}
}

def DockerCleanup(String stageDir)
{
	echo "Executing DockerCleanup..."
	script{		
		def stagePath="${stageDir}"
		
		sh "chmod +x ./shellScripts/DockerCleanup.sh "
		sh "./shellScripts/DockerCleanup.sh ${stagePath}"		
	}
}

def DeployContainer(String buildDir,String stageDir)
{
	echo "Executing DeployContainer..."
	script{		
		def stagePath="${stageDir}"
		def deployFlag="${params.Deploy}"
		def productVersion="${params.ProductVersion}"
		def unitFullPath="${params.SourcePath}/${params.ProductVersion}/lnx64/"
		
		sh "chmod +x ./shellScripts/DeployContainer.sh "
		sh "./shellScripts/DeployContainer.sh ${stagePath} ${deployFlag} ${unitFullPath} ${productVersion}"		
	}
}

def Purge(String dirName)
{
	echo "Executing Purge ..."
	script{		
		def fullPath="${dirName}"
		sh "chmod +x ./shellScripts/Purge.sh "
		sh "./shellScripts/Purge.sh ${fullPath}"		
	}
}

return this
