BEGIN {
	inParagraph = 0
}

/^ID .*/ {
	print "<article id=\"" $2 "\">"
	id = $2
	next
}

/^TITLE .*/ {
	$1 = ""
	print "<h3>" substr($0, 2) "</h3>"
	next
}

/^DATE .*/ {
	$1 = ""
	print "<div class=\"subhead\">" substr($0, 2) "</div>"
	next
}

/^SUBNOTE .*/ {
	n = $2
	$1 = ""
	$2 = ""
	$0 = substr($0, 3)
	$0 = gensub(/`([^`]*)`/, "<span class=\"code\">\\1</span>", "g", $0)
	notes[currentNote, "subnotes"]++
	subnotes[currentNote, n] = $0
	next
}

/^NOTE .*/ {
	n = $2
	$1 = ""
	$2 = ""
	$0 = substr($0, 3)
	$0 = gensub(/`([^`]*)`/, "<span class=\"code\">\\1</span>", "g", $0)
	notes[n] = $0
	notes[n, "subnotes"] = 0
	currentNote = n;
	next
}

/^IMAGE .*/ {
	url = $2
	$1 = ""
	$2 = ""
	print "<img src=\"" url "\" alt=\"" substr($0, 3) "\"/>"
	next
}

/^<.*/ {
	print $0
	next
}

NF==0 {
	if (inParagraph == 1) {
		print "</p>"
		inParagraph = 0
	}
	next
}

{
	if (inParagraph == 0) {
		print "<p>"
		inParagraph = 1
	}
	$0 = gensub(/{([0-9+])}/, "<sup><a href=\"#" id "_note\\1\">\\1</a></sup>", "g", $0)
	$0 = gensub(/`([^`]*)`/, "<span class=\"code\">\\1</span>", "g", $0)
	print $0
}

function chr(c)
{
    return sprintf("%c", c + 0)
}

END {
	if (inParagraph == 1) {
		print "</p>"
	}
	if (length(notes) > 0) {
		print "<div class=\"notes\">\n<h4>Notes</h4>"
		for (note = 1; note <= length(notes) / 2; note++) {
			print "<p id=\"" id "_note" note "\">" note ". " notes[note] "</p>"
			if (notes[note, "subnotes"] > 0) {
				print "<div class=\"subnotes\">"
				for (subnote = 1; subnote <= notes[note, "subnotes"]; subnote++) {
					print "<p id=\"" id "_note" note chr(subnote + 96) "\">" chr(subnote + 96) ". " subnotes[note, subnote] "</p>"
				}
				print "</div>"
			}
		}
		print "</div>"
	}
	print "</article>"
}

