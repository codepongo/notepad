<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="author" content="zuohaitao" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" type="text/css" href="css/mobi.css">
% if t in ['housework', 'work']:
    <link rel="shortcut icon" href="image/{{t}}.ico"/>
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="image/{{t}}57.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="image/{{t}}72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="image/{{t}}114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="image/{{t}}144.png" />
    <link rel="apple-touch-icon-precomposed" sizes="400x400" href="image/{{t}}.png" />
% else:
    <link rel="shortcut icon" href="image/notepad.ico"/>
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="image/notepad57.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="image/notepad72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="image/notepad114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="image/notepad144.png" />
    <link rel="apple-touch-icon-precomposed" sizes="400x400" href="image/notepad.png" />
%end 
    <title>{{title}}</title>
</head>
<body>
    <div class="flex-center flex-middle site-box" style="margin:20px">
    <div class="container" id="form" style="margin:20px">
        <div style="height:20px"></div>
        <form class="form" action="/login?t={{t}}" method="POST">
        <div class="flex-left units-gap">
            <label class="unit-0 text-right" for="multiple-inputs-name" style="width:100px">用户名：</label>
            <div class="unit"><input type="text" name="user" placeholder="Name"/></div>
        </div>
        <div class="flex-left units-gap">
            <label class="unit-0 text-right" for="multiple-inputs-name" style="width:100px">密码：</label>
            <div class="unit"><input type="password" name="password" placehoder="Password"/></div>
        </div>
        <br />
        <input class="btn" type="submit" value="登录" />
        </form>
    </div>
    </div>
</body>
</html>
