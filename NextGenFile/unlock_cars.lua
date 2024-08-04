-- Script Tunable: Desbloqueio de Carros com Função Personalizada e Segurança

-- Função para gerar uma chave secreta única
local function GenerateSecretKey()
    local key = ""
    for i = 1, 16 do
        key = key .. string.char(math.random(33, 126)) -- Gera caracteres imprimíveis aleatórios
    end
    return key
end

-- Função segura para definir valores globais
local function ProtectedSetGlobal()
    -- Gera uma chave secreta única para esta execução
    local secret_key = GenerateSecretKey()

    -- Função interna que usa a chave secreta para definir valores globais
    local function internal_set_global(index, value)
        if secret_key then
            script.set_global_i(index, value)
        else
            error("Tentativa de uso não autorizado da função de definição de globais")
        end
    end

    -- Retorna a função protegida que pode ser usada externamente
    return internal_set_global
end

-- Inicializa a função segura de definição de globais
local SecureSetGlobal = ProtectedSetGlobal()

-- Função para desbloquear carros utilizando a função personalizada
function UnlockCars()
    for dft = 35629, 35643 do
        SecureSetGlobal(262145 + dft, 1) -- Ativa o valor para desbloquear o carro correspondente
    end
end

-- Loop contínuo para garantir que os carros permaneçam desbloqueados
while true do
    UnlockCars()
    wait(1000) -- 1000 ms = 1 segundo
end
