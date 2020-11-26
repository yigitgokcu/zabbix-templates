#Count Pending Updates
[Int]$Count = 0
$Searcher = new-object -com "Microsoft.Update.Searcher"
$Searcher.Search("IsAssigned=1 and IsHidden=0 and IsInstalled=0").Updates | ForEach-Object { $Count++ } 
Set-Content -Path 'C:\Program Files\Zabbix Agent\scripts\zabbix_count_updates.txt' -Value $Count
