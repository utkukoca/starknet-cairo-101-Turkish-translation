######### Ex 02
## Assertleri anlamak
# Bu alıştırmada yapmanız gerekenler:
# - Bu sözleşmenin request_points() fonksiyonunu kullanın
# - Puanlarınız sözleşme tarafından gönderilir.

## Neleri öğreneceksiniz
# - Assertleri kullanmak
# - Depolama değişkenleri nasıl bildirilir
# - Depolama değişkenleri nasıl okunur
# - Alıcı işlevleri nasıl oluşturulur
# Assertler, iki değerin aynı olduğunu doğrulamanıza izin veren temel bir yapı taşıdır.
# Solidity'de require() işlevine benzerler
# Temel depolama hakkında daha fazla bilgi https://www.cairo-by-example.com/basics/storage

######### Genel yönergeler ve içe aktarmalar
#
#

%lang starknet
%builtins pedersen range_check

from starkware.starknet.common.syscalls import (get_caller_address)
from starkware.cairo.common.cairo_builtins import HashBuiltin
from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer
)

#
# Depolama değişkenlerinin bildirilmesi
# Depolama değişkenleri varsayılan olarak ABI aracılığıyla görünmez. Solidity'deki "özel" değişkenlere benzerler
#
# Bu değişken "felt" dir ve "my_secret_value_storage" olarak isimlendirilir
# Akıllı sözleşmeden, my_secret_value_storage.read() aracılığıyla okunabilir veya my_secret_value_storage.write() sayesinde yazılabilir.

@storage_var
func my_secret_value_storage() -> (my_secret_value_storage: felt):
end

#
# Alıcıları bildirme
# Genel değişkenler bir alıcı ile açıkça bildirilmelidir
#


@view
func my_secret_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (my_secret_value: felt):
    let (my_secret_value) = my_secret_value_storage.read()
    return (my_secret_value)
end

######### Constructor
# Bu işlev, sözleşme dağıtıldığında bir seferliğine çağrılır.
#
@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        _tderc20_address: felt,
        _players_registry: felt,
        _workshop_id: felt,
        _exercise_id: felt ,
        my_secret_value: felt
    ):
    ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id)
    my_secret_value_storage.write(my_secret_value)
    return ()
end

######### External functions
# # Bu fonksiyonlar başka kontratlar tarafından çağrılabilir
#

@external
func claim_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(my_value: felt):
    # Fonksiyonu çağıran cüzdan adresini okur.
    let (sender_address) = get_caller_address()
    # Depoda depolanan değeri okuma
    let (my_secret_value) = my_secret_value_storage.read()
    # Gönderilen değerin doğru olup olmadığı kontrol ediliyor
    # Assert'i bu şekilde kullanmak, Solidity'de "require" kullanmaya benzer
    assert my_value = my_secret_value
    # Kullanıcının alıştırmayı daha önce yapıp yapmadığını kontrol etme
    validate_exercise(sender_address)
    # Girilen adrese puanları "tokenları" gönderir.
    distribute_points(sender_address, 2)
    return ()
end







