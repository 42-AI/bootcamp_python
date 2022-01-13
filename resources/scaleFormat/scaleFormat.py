#!/usr/bin/env python

import sys
import re
import yaml
import textwrap


def loadScale( filename ):
	with open( filename, 'r' ) as fd:
		return yaml.load( fd.read() )


def printText( text, offset ):

	def printRegular( text, offset ):
		if text != u"":
			print textwrap.fill( text.encode( 'UTF-8' ),
								 initial_indent=" "*offset,
								 subsequent_indent=" "*offset,
								 expand_tabs = True,
								 replace_whitespace=True,
								 drop_whitespace=True
								 )
			print

	def printList( text, offset ):
		if text != u"":
			m = re.search( '(^\s*)\-', text )
			sub = len( m.groups()[0] ) + 2
			print textwrap.fill( text.encode( 'UTF-8' ),
								 initial_indent=" "*offset,
								 subsequent_indent=" "*(offset+sub),
								 expand_tabs = True,
								 replace_whitespace=True,
								 drop_whitespace=True
								 )

	acc = u""
	regular = True
	lines = text.split('\n')
	for line in lines:

		if re.search( '(^\s*)\-', line ):
			if regular:	printRegular( acc, offset )
			else: printList( acc, offset )
			regular = False
			acc = line

		elif line == u"":
			if regular:	printRegular( acc, offset )
			else:
				printList( acc, offset )
				print
			regular = True
			acc = line

		else:
			acc = acc + line if acc == "" else acc + ' ' + line.strip()

	if regular:	printRegular( acc, offset )
	else: printList( acc, offset )




def printQuestion( question ):
	name_len = len( question['name'] )
	left_pad = (76-name_len) / 2
	right_pad = (76-name_len) / 2 if name_len%2 == 0 else ((76-name_len) / 2) + 1
	print '# ' + '*'*76 + ' #'
	print '# ' + ' '*left_pad + question['name'].encode( 'UTF-8' ) + ' '*right_pad + ' #'
	print '# ' + '*'*76 + ' #'
	print '  - name:', question['name'].encode( 'UTF-8' )
	print '    position:', question['position']

	guidelines = question['guidelines']
	if guidelines != '':
		print '    guidelines: |\n'
		printText( guidelines, 6 )
	else: print "    guidelines: ''"


	print '    rating:', question['rating']
	print '    kind:', question['kind']
	print '    questions_skills:'
	for qs in question['questions_skills']:
		print '    - percentage:', qs['percentage']
		print '      name:', qs['name']
	print '\n'


def printSection( section ):
	name_len = len( section['name'] )
	left_pad = (76-name_len) / 2
	right_pad = (76-name_len) / 2 if name_len%2 == 0 else ((76-name_len) / 2) + 1
	print '\n# ' + '*'*76 + ' #'
	print '# ' + ' '*76 + ' #'
	print '# ' + ' '*left_pad + section['name'].encode( 'UTF-8' ) + ' '*right_pad + ' #'
	print '# ' + ' '*76 + ' #'
	print '# ' + '*'*76 + ' #'
	print '- name:', section['name'].encode( 'UTF-8' )
	print '  position:', section['position']

	description = section['description']
	if description != '':
		print '  description: |\n'
		printText( description, 4 )
	else: print "  description: ''"

	print '\n  questions:\n'
	for question in section['questions']:
		printQuestion( question )


def printHead( scale ):
	print '---'
	print 'name:', scale['name']
	print '\nlg:', scale['lg']
	print 'is_primary:', scale['is_primary']
	print 'correction_number:', scale['correction_number']
	print 'duration: ' + str(scale['duration']) + '\n'

	tags = [ 'comment', 'introduction_md', 'disclaimer_md', 'guidelines_md' ]
	for tag in tags:
		value = scale[tag]
		if value != '':
			print tag + ":|\n"
			printText( value, 2 )
		else: print tag + ": ''"
		print

	print 'sections:'
	for section in scale['sections']:
		printSection( section )


if __name__ == '__main__':
	scale = loadScale( sys.argv[1] )
	printHead( scale )
	print '\n# ' + '*'*76 + ' #'
