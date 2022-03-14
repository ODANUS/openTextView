$("input[aria-label='앱 이름']").value = $("textarea[aria-label='자세한 앱 설명']").value.split("\n")[0]
$("input[aria-label='간단한 앱 설명']").value = $("textarea[aria-label='자세한 앱 설명']").value.split("\n")[1]
$("textarea[aria-label='자세한 앱 설명']").value = $("textarea[aria-label='자세한 앱 설명']").value.split("\n").slice(2,100).join("\n").replaceAll("\"","")