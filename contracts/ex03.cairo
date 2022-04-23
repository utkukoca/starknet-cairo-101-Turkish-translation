######### Ex 03
# Sözleşme değişkenlerini değiştirmek için sözleşme fonksyionlarını kullanma
# Bu alıştırmada yapmanız gerekenler:
# - Adresinize özgü dahili bir sayacı değiştirmek için bu sözleşmenin fonksiyonlarını kullanın
# - Bu sayaç belirli bir değere ulaştığında, belirli bir işlevi çağırın
# - Puanlarınız sözleşme tarafından gönderilir.

# Ne öğreneceksiniz
# - Eşlemeler(Mappings) nasıl bildirilir
# - Eşlemeler nasıl okunur ve yazılır
# - Depolama değişkenlerini değiştirmek için bir fonksiyon nasıl kullanılır

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

#  Her 'adress' değişkeni 'felt' olan user_counters_storage adında başka bir eşleşme yapıyor.
@storage_var
func user_counters_storage(account: felt) -> (user_counters_storage: felt):
end

#
# Alıcıları bildirme
# Genel değişkenler bir alıcı ile açıkça bildirilmelidir
#

# Eşlemelerimiz için bir alıcı bildiriyoruz. Sayacını okumak istediğiniz hesap değişken olarak bir parametre alır
@view
func user_counters{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(account: felt) -> (user_counter: felt):
    let (user_counter) = user_counters_storage.read(account) 
    return (user_counter)
end

#
# Constructor
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

#
# External functions
#

@external
func claim_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    # Fonksiyonu çağıran cüzdan adresini okur.
    let (sender_address) = get_caller_address()
    # Kullanıcının sayacının 7'ye eşit olması gerektğini belirtir.
    let (current_counter_value) = user_counters_storage.read(sender_address)
    assert current_counter_value = 7

    # Kullanıcının alıştırmayı daha önce yapıp yapmadığını kontrol etme
    validate_exercise(sender_address)
    # Girilen adrese puanları "tokenları" gönderir.
    distribute_points(sender_address, 2)
    return ()
end

@external
func reset_counter{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    # Cüzdan adresini okur
    let (sender_address) = get_caller_address()
    # Kullanıcı sayacını yeniden başlatır
    user_counters_storage.write(sender_address, 0)
    return()
end

@external
func increment_counter{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    # Cüzdan adresini okur
    let (sender_address) = get_caller_address()
    # Depolamadan anlık olarak sayacın değerini okur
    let (current_counter_value) = user_counters_storage.read(sender_address)
    # Yazan sayı kadar artırır ve depolamayı yeniden düzenler
    user_counters_storage.write(sender_address, current_counter_value+2)
    return()
end

@external
func decrement_counter{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    # Cüzdan adresini okur
    let (sender_address) = get_caller_address()
    # Depolamadan anlık olarak sayacın değerini okur
    let (current_counter_value) = user_counters_storage.read(sender_address)
    # Yazan sayı kadar azaltıp yeniden depolamayı günceller
    user_counters_storage.write(sender_address, current_counter_value-1)
    return()
end





