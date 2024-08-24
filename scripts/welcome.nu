# Terminal greater for nushell

use std

# COLORS
let c1 = ansi cyan_bold
let c2 = ansi blue_bold
let c3 = ansi white_bold
let reset = ansi reset
# COLORS

let birthdate = (stat / | awk '/Birth: /{print $2}' | split row "-") #YY-DD-MM
let bd		  = ($"($birthdate.2)/($birthdate.1)/($birthdate.0)") | into datetime

let kernel = sys host | get kernel_version | to text
let osname = sys host | get name | to text

def diskdata [mnt] {
	let total = (sys disks | where mount == $mnt | get total | to text | split row " " | get 0 | into float)
	let free  = (sys disks | where mount == $mnt | get free  | to text | split row " " | get 0 | into float)
	let used  = (($total - $free) | into string | split chars) 
	#print $used
	echo $"($used.0? | default 0)($used.1? | default '')($used.2? | default '')($used.3? | default '')GiB / ($total) GiB"
}

def dayssince [opt] {
	match $opt {
		"linux" => {
			let diff = (date now) - 2024-07-07 | into record
			return (($diff.year? | default 0) + ($diff.week? | default 0) * 7 + ($diff.day? | default 0))
		}
		"osbirth" => {
			let diff = (date now) - $bd | into record
			#print ($diff | to text)
			#echo $"($diff.week * 7 + $diff.day)"
			return (($diff.year? | default 0) + ($diff.week? | default 0) * 7 + ($diff.day? | default 0))
			
		}
	}
	
}

let linesx = [$"Hello, ($c1)($env.USER)(ansi reset)@($c2)(sys host | get hostname | to text)(ansi reset)!",
			  $"($c3)-------------------------($reset)",
			  $"($c2)Kernel version         ($c3)=============>($reset) (ansi white)($kernel)"
			  $"($c1)Current memory usage   ($c3)=============>($reset) (sys mem | get used | to text) / (sys mem| get total | to text)(ansi reset)",
			$"($c2)Current disk usage \(/\) ($c3)=============>($reset) (diskdata '/')(ansi reset)",
			  $"($c1)Started using linu     ($c3)=============>($reset) 07/07/2024",
			  $"($c2)Current date           ($c3)=============>($reset) (date now | format date '%d/%m/%Y')",
			  $"($c1)Days since             ($c3)=============>($reset) (dayssince linux)",
			  $"($c2)Shell                  ($c3)=============>($reset) ($env.SHELL)",
			  $"($c1)Days since install     ($c3)=============>($reset) (dayssince osbirth)"]

let asciifedsmall = [
	"       _____      ",
	"      /   __)\\    ",
	"      |  /  \\ \\   ",
	"   ___|  |__/ /   ",
	"  / (_    _)_/    ",
	" / /  |  |        ",
	" \\ \\__/  |        ",
	"  \\(_____/        ",
	"                  "
]

print ""
print -n $asciifedsmall.0
print $linesx.0
print -n $asciifedsmall.1
print $linesx.1
print -n $asciifedsmall.2
print $linesx.2
print -n $asciifedsmall.3
print $linesx.3
print -n $asciifedsmall.4
print $linesx.4
print -n $asciifedsmall.5
print $linesx.5
print -n $asciifedsmall.6
print $linesx.6
print -n $asciifedsmall.7
print $linesx.7
print -n $asciifedsmall.8
print $linesx.8
print -n $asciifedsmall.8
print $linesx.9

print ""
