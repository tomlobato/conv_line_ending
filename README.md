conv_line_ending
================

Search files and replace line endings.


install
=======

git clone https://github.com/tomlobato/conv_line_ending

chmod 755 conv_line_ending

sudo cp -a conv_line_ending /usr/local/bin/


usage example
=============

tom@mobile:~ $ cd ~/my/bad/files
tom@mobile:~/my/bad/files$ conv_line_ending

1 app/models/robot.rb
2 app/mailers/mailer.rb
3 lib/extend_plans.rb

Found 3 files containing \r\n.
Convert \r\n to \n for:

a:	all
<n>:	file <n>
q:	quit

(a)? 2
app/mailers/mailer.rb converted successfully.

a:	all
<n>:	file <n>
q:	quit

(a)? q

tom@mobile: ~/my/bad/files $

