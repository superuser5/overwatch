# overwatch
A lightweight processing mechanism for Masscan (-oL) outputs.


1. mkdir /root/scripts/ /root/scripts/circus/ /root/scripts/temp/
2. cd /root/scripts/circus/
3. git clone https://github.com/ghostinthecable/overwatch
4. mv overwatch/* ../ ; rm -rf overwatch

Now, to execute;

1. Execute 'proper-importer.sh' first
2. Find a way to grab '$sendfile' defined on line 38 (you can see how we did it in the history of the script)
Hint: https://github.com/ghostinthecable/overwatch/commit/c5e199a2a6aa048913f488309d50417d867a47b9#diff-7d4ae222a8133c6a7689f4ebfbbf9ada
3. Execute 'proper-python-screenshot-list-generator.sh' to prepare the screenshot list (Argus Panoptes)
4. Execute 'funky-five-adapter.sh' to organize the main lists into split directories depending on output
