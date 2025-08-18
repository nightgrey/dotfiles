# https://github.com/schlagmichdoch/PairDrop/blob/master/pairdrop-cli/send-with-pairdrop
function send-with-pairdrop
    # Remove the last argument and pass the rest to pairdrop
    pairdrop $argv[1..-2]
end
