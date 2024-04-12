package com.ProjectOnlineShop.Model;

import com.Enum.Sexo;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

import java.io.IOException;

public class SexoDeserializer extends JsonDeserializer<Sexo> {

    @Override
    public Sexo deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException {
        String value = jsonParser.getValueAsString().toUpperCase();
        if (value.equals("HOMBRE") || value.equals("MUJER")) {
            return Sexo.valueOf(value);
        } else {
            throw new IllegalArgumentException("Valor inválido para Sexo: " + value);
        }
    }
}
