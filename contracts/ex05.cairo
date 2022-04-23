######### Ex 05
# Public/private variables
# Bu alıştırmada yapmanız gerekenler:
# - Özel bir değişkene (Private variables) atanmak için bir fonksyion kullanın
# - Bu değişkeni bir genel değişkende (Public variables) çoğaltmak için bir fonksiyon kullanın
# - Özel değişkenin doğru değerini bildiğinizi göstermek için bir fonksyion kullanın
# - Puanlarınız sözleşme tarafından gönderilir.


%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_not_zero
from starkware.starknet.common.syscalls import (get_caller_address)

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

# Bu depolama slotlarındaki değerleri okumanız gerekecek. Ama hepsinin alıcısı yok!
@storage_var
func user_slots_storage(account: felt) -> (user_slots_storage: felt):
end

@storage_var
func user_values_public_storage(account: felt) -> (user_values_public_storage: felt):
end

@storage_var
func values_mapped_secret_storage(slot: felt) -> (values_mapped_secret_storage: felt):
end

@storage_var
func was_initialized() -> (was_initialized: felt):
end

@storage_var
func next_slot() -> (next_slot: felt):
end


#
# Alıcıları bildirme
# Genel değişkenler bir alıcı ile açıkça bildirilmelidir
#

@view
func user_slots{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(account: felt) -> (user_slot: felt):
    let (user_slot) = user_slots_storage.read(account)
    return (user_slot)
end

@view
func user_values{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(account: felt) -> (user_value: felt):
    let (value) = user_values_public_storage.read(account)
    return (value)
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
func claim_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(expected_value: felt):
    # Fonksiyonu çağıran cüzdan adresini okur.
    let (sender_address) = get_caller_address()
    # Kullanıcıya bir slot atanıp atanmadığı kontrol ediliyor
    let (user_slot) = user_slots_storage.read(sender_address)
    assert_not_zero(user_slot)

    # Kullanıcı tarafından sağlanan değerin beklediğimiz değer olup olmadığını kontrol etmek
    # Hala sinsice
    let (value) = values_mapped_secret_storage.read(user_slot)
    assert value = expected_value + 23

    # Kullanıcının alıştırmayı daha önce yapıp yapmadığını kontrol etme
    validate_exercise(sender_address)
    # Girilen adrese puanları "tokenları" gönderir.
    distribute_points(sender_address, 2)
    return ()
end

@external
func assign_user_slot{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    # Fonksiyonu çağıran cüzdan adresini okur.
    let (sender_address) = get_caller_address()
    let (next_slot_temp) = next_slot.read()
    let (next_value) = values_mapped_secret_storage.read(next_slot_temp + 1)
    if next_value == 0:
        user_slots_storage.write(sender_address, 1)
        next_slot.write(0)
    else:
        user_slots_storage.write(sender_address, next_slot_temp + 1)
        next_slot.write(next_slot_temp + 1)
    end
    return()
end

@external
func copy_secret_value_to_readable_mapping{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    # Fonksiyonu çağıran cüzdan adresini okur.
    let (sender_address) = get_caller_address()
    # Kullanıcıya bir slot atanıp atanmadığı kontrol ediliyor
    let (user_slot) = user_slots_storage.read(sender_address)
    assert_not_zero(user_slot)

    # Kullanıcı gizli değerini okuma
    let (secret_value) = values_mapped_secret_storage.read(user_slot)

    # Erişilebilir olmayan değerler _mapped_secret_storage'dan değer kopyalıyor
    user_values_public_storage.write(sender_address, secret_value-23)
    return()
end


#
# External functions - Administration
# Bunları yalnızca yöneticiler iletişime geçebilir. Alıştırmayı bitirmek için onları anlamanıza gerek yok.
#

@external
func set_random_values{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(values_len: felt, values: felt*):

    # Rastgele değerlerin zaten başlatılıp başlatılmadığını kontrol edin
    let (was_initialized_read) = was_initialized.read()
    assert was_initialized_read = 0
    
    # Depoda geçirilen değerlerin saklanması
    set_a_random_value(values_len, values)

    # Değer deposunun başlatıldığını işaretleyin
    was_initialized.write(1)
    return()
end

func set_a_random_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(values_len: felt, values: felt*):
    if values_len == 0:
        # Start with sum=0.
        return ()
    end


    set_a_random_value(values_len=values_len - 1, values=values + 1 )
    values_mapped_secret_storage.write(values_len-1, [values])

    return ()
end



