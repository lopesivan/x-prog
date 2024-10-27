#!/usr/bin/env bash

run() {
	cat $1 |
		while read line; do

			# se a linha é branca ignore
			[ "$line" ] || continue

			# se a linha começa com # ignore
			if expr "$line" : '#' >/dev/null; then
				continue
			fi

			echo $line | sed 's/|//' |
				{
					read file linkname

					# if exist link `$linkname' then remove.
					_l=$(brew --prefix)/scripts/bin/$linkname
					test -L $_l && echo rm $_l

					echo chmod -x $file
				} | sh

		done
}

run ./programs.txt
