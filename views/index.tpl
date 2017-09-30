<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="author" content="zuohaitao" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>{{t}} | {{app}}</title>
    <link rel="stylesheet" type="text/css" href="css/wangEditor.css">
    <link rel="stylesheet" type="text/css" href="css/mobi.css">
</head>
<body>
    <div class="flex-center">
    <div class="container">
    <div id="exhibition"> {{!content}} </div>
    <div id="editor">
        <div id="_editor" style="width:100%;height:400px">
        </div>
    </div>
    <input class="btn" type="button" id="operator" />
    </div>
    </div>

    <script type="text/javascript" src="js/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="js/wangEditor.js"></script>
    <script type="text/javascript">
        var editor = new wangEditor('_editor');
        editor.config.menus = [
        'bold',
        'underline',
        'strikethrough',
        'img',
        'table',
        'unorderlist',
        'orderlist'
        ];
        editor.create();
        function exhibit() {
            $("#operator").val("edit");
            $("#editor").hide();
            $("#exhibition").show();
            $("#operator").click(edit);
        }
        function edit() {
            $("#operator").val("save");
            $("#editor").show();
            $("#exhibition").hide();
            $("#operator").click(function() {
                var data = editor.$txt.html();
                $.post("/?t={{t}}", data, function(d, s) {
                    window.location.reload();
                });
            });
        }
        $(document).ready(function(){
<% content = content.replace("'", "\\'").replace('\n', '') %>
            editor.$txt.html('{{!content}}');
            exhibit();
        });
    </script>
</body>
</html>
