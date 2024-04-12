package com.Enum;

public enum Sexo {
    HOMBRE,
    MUJER;

    public static Sexo valueOfIgnoreCase(String key) {
        String upperKey = key.toUpperCase();
        if (upperKey.equals("HOMBRE") || upperKey.equals("MUJER")) {
            return Sexo.valueOf(upperKey);
        } else {
            throw new IllegalArgumentException("Valor inválido, solo existen 2 sexos: " + key);
        }
    }
}

    

