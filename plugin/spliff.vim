" spliff.vim - Select and open a buffer in a split
"
" :help spliff.txt

if exists('lodedspliff')
	finish
endif
let loadedspliff = 1

" Count open buffers
function! NrBufs()
	let i = bufnr('$')
	let j = 0
	while i >= 1
		if buflisted(i)
			let j+=1
		endif
		let i-=1
	endwhile
	return j
endfunction


" Open buffer in vertical split, if there are more than one buffers. If not,
" open same buffer.
function! s:Spliff_v()
	let bufsum = NrBufs()
	" If one buffer exists, split that
	if bufsum ==? 1
		let curbufnum = bufnr('%')
		execute ':vert sb '.curbufnum
		" echo '"'.bufname('').'"'
	else
		call inputsave()
		let bufswitch = input('Open buffer(v):')
		call inputrestore()
		execute ':vert sb '.bufswitch
		" echo '"'.bufname('').'"'
	endif
endfunction

" Open buffer in horizontal split, if there are more than one buffers. If not,
" open same buffer.
function! s:Spliff_h()
	let bufsum = NrBufs()
	if bufsum ==? 1
		let curbufnum = bufnr('%')
		execute ':sb '.curbufnum
		" echo '"'.bufname('').'"'
	else
		call inputsave()
		let bufswitch = input('Open buffer(h):')
		call inputrestore()
		execute ':sb '.bufswitch
		" echo '"'.bufname('').'"'
	endif
endfunction

function s:Spliff_u()
	let bufsum = NrBufs()
	if bufsum ==? 1
		let curbufnum = bufnr('%')
		execute ':aboveleft '.curbufnum
	else
		call inputsave()
		let bufswitch = input('Open buffer(u):')
		call inputrestore()
		execute ':aboveleft '.bufswitch
	endif
endfunction

" Open buffer number
function! s:Spliff_o()
	call inputsave()
	let bufswitch = input('Open buffer(same):')
	call inputrestore()
	execute ':buffer '.bufswitch
endfunction

" A fast way to close a split
function! s:Closesplit()
	let opensplits = winnr('$')
	if winnr('$') > 1
		execute ':q'
	else
		echo 'Only window, not closing'
	endif
endfunction

" Commands ready for mapping
" Suggested mappings: ^n ^m ^o and ^c respectively.
silent command! Spliffv :call <SID>Spliff_v()
silent command! Spliffh :call <SID>Spliff_h()
silent command! Spliffo :call <SID>Spliff_o()
silent command! Spliffu :call <SID>Spliff_u()
silent command! Spliffc :call <SID>Closesplit()
