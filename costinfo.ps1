
'''ps1
NAME
    Get-AzConsumptionUsageDetail
    
SYNOPSIS
    Get usage details of the subscription.
    
   
##  Costing Details
##
$envset=set-Azcontext -subscriptionId <subid>
$StartTime = Get-Date
$EndTime = $startTime.AddHours(3.0)
$vStorageAccountRG = "rg-Lab"
$stgAccount = Get-AzStorageAccount -Name zeusslabdiag -ResourceGroupName $vStorageAccountRG
$SASToken = New-AzStorageAccountSASToken -Service Blob -ResourceType Container, Object -Permission "racwdlup" -startTime $StartTime -ExpiryTime $EndTime -Context $StgAccount.Context
$stgcontext = New-AzStorageContext -storageAccountName $stgAccount.StorageAccountName -SasToken $SASToken

#$startdt=(Get-Date (Get-Date).AddDays(-2) -format yyyy-MM-dd)
#$enddt=(Get-Date (Get-Date).AddDays(-1) -format yyyy-MM-dd)

$startdt="2020-01-01"
$enddt="2020-06-30"

$vFileName="vcost0710.csv"
$subs=get-azsubscription | where name -notlike '<subscriptname-name>'
foreach ($sub in $subs)
  {
$envset=set-Azcontext -subscriptionId $sub.id
#$Consumption=Get-AzConsumptionUsageDetail -StartDate '2020-07-01'  -enddate '2020-10-31' 
$Consumption=Get-AzConsumptionUsageDetail -StartDate $startdt  -enddate $enddt 
$consumption | select SubscriptionName,usageStart,Usageend,InstanceName,pretaxcost,consumedService |  export-csv $vFileName -NoTypeInformation -append
  }
$tmp2 = Set-AzStorageBlobContent -File $vFileName -Container cost -Context $stgcontext -Force

   
   
   
    --- Example 1: Get usage details with expand of MeterDetails ---
    
    PS C:\> Get-AzConsumptionUsageDetail -Expand MeterDetails -Top 10
    
    
    
    
    
    --------- Example 2: Get usage details with date range ---------
    
    PS C:\> Get-AzConsumptionUsageDetail -StartDate 2017-10-02 -EndDate 2017-10-05 -Top 10
    
   
    
    
    Example 3: Get usage details of BillingPeriodName with InstanceName filter
    
    PS C:\> Get-AzConsumptionUsageDetail -BillingPeriodName 201710 -InstanceName 1c2052westus -Top 10
   
	
	$startdate=@('2020-01-01','2020-02-01','2020-03-01','2020-04-01','2020-05-01','2020-06-01','2020-07-01','2020-08-01','2020-09-01','2020-10-01','2020-11-01','2020-12-01')
	$enddate=  @('2020-01-31','2020-02-28','2020-03-31','2020-04-30','2020-05-31','2020-06-30','2020-07-31','2020-08-31','2020-09-30','2020-10-31','2020-11-30','2020-12-31')
    $month=@()
	for ($i=0;$i -le 11;$i++)
	{
	 $CostTotal = 0
	 $Costs=0
     $Consumption=Get-AzConsumptionUsageDetail -StartDate $startDate[$i]  -enddate $endDate[$i]
	 $Costs = $Consumption.PretaxCost 
     foreach ($Cost in $Costs) { $CostTotal += $Cost }
     $month = $month + $CostTotal
	}
	$subname='Av'
	$costpermonth =  @{
	              Sub=$subname
                  Jan=$month[0]
                  Feb=$month[1]
				  Mar=$month[2]
				  Apr=$month[3]
                  May=$month[4]
				  Jun=$month[5]
				  Jul=$month[6]
                  Aug=$month[7]
				  Sep=$month[8]
				  Oct=$month[9]
                  Nov=$month[10]
				  Dec=$month[11]
				  }
	write-output $costpermonth | export-csv c:\temp\newdata.csv
	
	$obj = New-Object -Type PSObject -Prop $costpermonth
$array += $obj

	$costpermonth =  @{
                  1=$month[0]
                  2=$month[1]
				  3=$month[2]
				  4=$month[3]
                  5=$month[4]
				  6=$month[5]
				  7=$month[6]
                  8=$month[7]
				  9=$month[8]
				  10=$month[9]
                  11=$month[10]
				  12=$month[11]
				  }
	$array = @()			  
$obj = New-Object -Type PSObject -Prop $Costpermonth	
$array += $obj
	
$Consumption=Get-AzConsumptionUsageDetail -StartDate '2020-01-01'  -enddate '2020-04-30' 
$consumption | select SubscriptionName,usageStart,Usageend,InstanceName,pretaxcost,consumedService | ft 
$xx | export-csv -path 'c:\temp\x.csv' 

   

	@(1,2,3), @(10,20,30)
    $props = @{Username='whatever'
>>            ProfilePath='this'
>>            ProfileSID='12334'}
>> $obj = New-Object -Type PSObject -Prop $props

$costpermonth = @{
                  Jan=$month[0]
                  Feb=$month[1]
				  Mar=$month[2]
				  Apr=$month[3]
                  May=$month[4]
				  Jun=$month[5]
				  Jul=$month[6]
                  Aug=$month[7]
				  Sep=$month[8]
				  Oct=$month[9]
                  Nov=$month[10]
				  Dec=$month[11]
				  }
				  
$t = @(@('AV'),@({Jan=$month[0],
				  Feb=$month[1],
				  Mar=$month[2]
                }))


$t = @(@(1,2,3), @(10,20,30))
'''
