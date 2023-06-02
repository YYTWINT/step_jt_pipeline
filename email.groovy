def sendEmail(String buildDir, String stageDir)
{
	def CPNum = "NA";
	if (params.CPNumber != null){
		CPNum = params.CPNumber
	}
 
	def subject = "Job Executed '${env.JOB_NAME} - [${env.BUILD_NUMBER}] - ${currentBuild.currentResult}'"
	def details = """
				Hi team; <br>
				Please see details of latest build as below: <br><br>
				
				 <style type="text/css">
				.tg  {border-collapse:collapse;border-color:#9ABAD9;border-spacing:0;}
				.tg td{background-color:#EBF5FF;border-color:#9ABAD9;border-style:solid;border-width:1px;color:#444;
				  font-family:Arial, sans-serif;font-size:14px;overflow:hidden;padding:10px 5px;word-break:normal;}
				.tg th{background-color:#409cff;border-color:#9ABAD9;border-style:solid;border-width:1px;color:#fff;
				  font-family:Arial, sans-serif;font-size:14px;font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
				.tg .tg-hmp3{background-color:#D2E4FC;text-align:left;vertical-align:top}
				.tg .tg-0lax{text-align:left;vertical-align:top}
				.tg .tg-ur59{border-color:#343434;text-align:left;vertical-align:top}
				</style>

				<table class="tg">
				<thead>
				  <tr>
					<th class="tg-0lax">Build paramter</th>
					<th class="tg-0lax">Value</th>
				  </tr>
				</thead>
				<tbody>
				  <tr>
					<td class="tg-hmp3">Job</td>
					<td class="tg-hmp3">${env.JOB_NAME}</td>
				  </tr>
				  <tr>
					<td class="tg-0lax">Build number</td>
					<td class="tg-ur59">${env.BUILD_NUMBER}</td>
				  </tr>
				  
				  <tr>
					<td class="tg-hmp3">Product Version</td>
					<td class="tg-hmp3">${params.ProductVersion}</td>
				  </tr>
				  <tr>
					<td class="tg-0lax">Unit path</td>
					<td class="tg-ur59">${buildDir}</td>
				  </tr>
				  <tr>
					<td class="tg-hmp3">Stage path</td>
					<td class="tg-hmp3">${stageDir}</td>
				  </tr>
				  <tr>
					<td class="tg-hmp3">Deploy flag</td>
					<td class="tg-hmp3">${params.Deploy}</td>
				  </tr>
				  <tr>
					<td class="tg-0lax">Status</td>
					<td class="tg-ur59">${currentBuild.currentResult}</td>
				  </tr>
				  <tr>
					<td class="tg-hmp3">Job log details</td>
					<td class="tg-hmp3"><a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></td>
				  </tr>
				 
				</tbody>
				</table>
				
				<br><br>
				Regards; <br>
				YYTWINT
				
				"""
	emailext(
		subject: subject,
		body: details,
		to: 'yytwint.sisw@siemens.com,roma.mohapatra@siemens.com'
	)
}
return this

