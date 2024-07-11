/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2023. All rights resvered.
 */
package jwt.interfaces

from crypto import keys.*

/*
 * RSA Public/Private Key provider.
 */
public interface RSAKeyProvider<U, R> <: KeyProvider<U, R> {
    mut prop padType:PadOption{
        get() {
            PKCS1
        }
        set(value){}
    }
}
