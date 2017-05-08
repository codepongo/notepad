<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>{{t}} | {{app}}</title>
    <link rel="stylesheet" type="text/css" href="css/wangEditor.css">
    <style type="text/css">
        #_editor {
            width: 100%;
            height: 500px;
        }
        #editor {
            width: 100%;
            height: 500px;
        }
        #operator {
            width: 100%;
            height: 100px;
        }
    </style>
</head>
<body>
    <div id="exhibition"> {{!content}} </div>
    <div id="editor">
        <div id="_editor">
        </div>
    </div>
    <br />
    <input type="button" id="operator" />

    <script type="text/javascript" src="js/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="js/wangEditor.js"></script>
    <script type="text/javascript">
        var editor = new wangEditor('_editor');
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
            editor.$txt.html('{{!content}}');
            exhibit();
        });
    </script>
</body>
</html>
