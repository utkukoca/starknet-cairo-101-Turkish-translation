######### Ex 01
## Basit bir public kontrat fonksiyonu kullanma
# Bu alıştırmada yapmanız gerekenler:
# - Bu sözleşmenin request_points() işlevini kullanın
# - Puanlarınız sözleşme tarafından verilir.

## Ne öğreneceksin
# - Genel akıllı sözleşme sözdizimi
# - Bir işlevi çağırmak

######### Genel yönergeler ve içe aktarmalar
#
#

%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import (get_caller_address)

from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer
)


######### Constructor
# Bu işlev, sözleşme dağıtıldığında bir seferliğine çağrılır.
#
@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        _tderc20_address: felt,
        _players_registry: felt,
        _workshop_id: felt,
        _exercise_id: felt  
    ):
    ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id)
    return ()
end

######### External functions
# Bu fonksiyonlar başka kontratlar tarafından çağrılabilir
#

# Bu fonksiyonun adı: claim_points
# (sender_address) adında bir argüman alabilir, bu veri tipi "felt" dir (integer gibi ama daha farklı). "felt" hakkında daha fazla bilgiyi burada bulabilirsiniz https://www.cairo-lang.org/docs/hello_cairo/intro.html#field-element
# Ayrıca bazı kesin argümanları var (syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr). daha fazlası burada https://www.cairo-lang.org/docs/how_cairo_works/builtins.html
@external
func claim_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    # Fonksiyonu çağıran cüzdan adresini okur.
    let (sender_address) = get_caller_address()
    # Kullanıcının daha önce bu fonksiyonu çağırıp çağrımadığını kontrol eder.
    validate_exercise(sender_address)
    # Girilen adrese puanları "tokenları" gönderir.
    distribute_points(sender_address, 2)
    return ()
end



