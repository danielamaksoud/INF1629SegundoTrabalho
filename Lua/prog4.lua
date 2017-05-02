-- =/=/=/=/=/=/=/=/=/=/
-- I N F I N I T E   M I R R O R
-- =/=/=/=/=/=/=/=/=/=/


-- Tratamos um erro de uso do programa
if #arg < 1 then
    print ("Uso: lua " .. arg[0] .. " <arquivo-de-teste>")
    return
end

function count(word_list, stopwords, wordfreqs)
	local word
  	if #words == 0 then
    	return
  	else
    	word = words[1]
    	if stopwords[word] then
      		if wordfreqs[word] then
        		wordfreqs[word] = wordfreqs[word] + 1
      		else
        		wordfreqs[word] = 1
      		end
      		count(table.remove(words, 1), stopwords, wordfreqs)
 		end	   
    end
end

function wf_print(wordfreq)
	--if #wordfreq == 0 then
	--	print('Tabela Vazia')
	--	return
	--else
		for c, v in pairs(wordfreq) do
  			print(c .. "  -  " .. v)
		end
	--end
end

-----
-- COLETA STOPWORDS DO ARQUIVO DE STOPWORDS
------

-- Abrimos o arquivo stop_words.txt para leitura
local stop_words_file = io.open("../stop_words.txt", "r")
local stop_words_text = stop_words_file:read"*all" -- Variavel para armazenar o texto

-- Fechamos o arquivo stop_words.txt
stop_words_file:close()

-- Criamos uma tabela vazia chamada stop_words
local stop_words = {}

-- Separamos as palavras de parada do arquivo stop_words.txt e as salvamos na tabela stop_words
stop_words_text = stop_words_text:gsub(",", " ")

for word in stop_words_text:gmatch"%w+" do
  stop_words[word] = true
end



-----
-- COLETA PALAVRAS DO ARQUIVO DE TESTE
------

-- Abrimos o arquivo test.txt para leitura
local test_file = io.open(arg[1], "r")
local test_text = test_file:read"*all":lower() -- Variavel para armazenar o texto

-- Fechamos o arquivo test.txt
test_file:close()

test_text = test_text:gsub(","," ")


-- Criamos a tabela  words com todas as palavras que não são stop_words do test_text.

words = {}

for word in test_text:gmatch"%w+" do
	table.insert(words,word)
end

print("Tabela de palavras a serem avaliadas:")
print(unpack(words))

-- Criamos uma tabela vazia word_freqs para contar as frequencias das palavras que não são stopwords
local word_freqs = {}  

--- Parte importante

count(words, stop_words, word_freqs)

print("Tamanho da Tabela word_freqs: " .. #word_freqs)

wf_print(word_freqs)




