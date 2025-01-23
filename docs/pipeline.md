# CI/CD Pipeline Architecture

```mermaid
flowchart TD
    subgraph DEV["Development"]
        A[Developer Push] --> B[Feature Branch]
        B --> C[Run Tests]
        C --> D[Terraform Format]
        D --> E[Terraform Plan]
    end

    subgraph NONPROD["Non-Prod Environment"]
        E --> F[Build Docker Image]
        F --> G[Test Image]
        G --> H[Deploy to Non-Prod]
        H --> I[Integration Tests]
    end

    subgraph PR["Pull Request Process"]
        I --> J[Create PR]
        J --> K[Code Review]
        K --> L[Approval Required]
    end

    subgraph PROD["Production Environment"]
        L --> M[Merge to Main]
        M --> N[Terraform Plan Prod]
        N --> O[Security Check]
        O --> P[Deploy to Prod]
        P --> Q[Monitoring]
    end

    classDef default fill:#f9f9f9,stroke:#333,stroke-width:2px;
    classDef dev fill:#e1f7d5,stroke:#82c91e,stroke-width:2px;
    classDef nonprod fill:#ffedcc,stroke:#ffa94d,stroke-width:2px;
    classDef pr fill:#f7d5e1,stroke:#e64980,stroke-width:2px;
    classDef prod fill:#dae8fc,stroke:#4c6ef5,stroke-width:2px;

    class DEV dev;
    class NONPROD nonprod;
    class PR pr;
    class PROD prod;
```

## Descripción del Pipeline

1. **Fase de Desarrollo**:
   - Push del desarrollador
   - Branch de feature
   - Tests iniciales
   - Verificación de formato Terraform
   - Plan de Terraform

2. **Ambiente Non-Prod**:
   - Build de imagen Docker
   - Tests de la imagen
   - Despliegue a non-prod
   - Tests de integración

3. **Proceso de Pull Request**:
   - Creación de PR
   - Code review
   - Aprobación requerida

4. **Ambiente de Producción**:
   - Merge a main
   - Plan de Terraform para prod
   - Verificación de seguridad
   - Despliegue a producción
   - Monitoreo

