{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE UndecidableInstances #-}

module Cardano.Ledger.Alonzo where

import Cardano.Ledger.Alonzo.Data (AuxiliaryData)
import Cardano.Ledger.Alonzo.PParams (PParams, PParamsUpdate, updatePParams)
import Cardano.Ledger.Alonzo.Scripts (Script)
import Cardano.Ledger.Alonzo.Tx (Tx)
import Cardano.Ledger.Alonzo.TxBody (TxBody, TxOut)
import Cardano.Ledger.AuxiliaryData (AuxiliaryDataHash (..), ValidateAuxiliaryData (..))
import qualified Cardano.Ledger.Core as Core
import qualified Cardano.Ledger.Crypto as CC
import Cardano.Ledger.Era
import Cardano.Ledger.Mary.Value (Value)
import Cardano.Ledger.SafeHash (hashAnnotated)
import Cardano.Ledger.Shelley.Constraints (UsesPParams (..), UsesValue)

-- | The Alonzo era
data AlonzoEra c

instance
  (CC.Crypto c) =>
  Era (AlonzoEra c)
  where
  type Crypto (AlonzoEra c) = c

type instance Core.TxOut (AlonzoEra c) = TxOut (AlonzoEra c)

type instance Core.TxBody (AlonzoEra c) = TxBody (AlonzoEra c)

type instance Core.TxOut (AlonzoEra c) = TxOut (AlonzoEra c)

type instance Core.Value (AlonzoEra c) = Value c

type instance Core.Script (AlonzoEra c) = Script (AlonzoEra c)

type instance Core.AuxiliaryData (AlonzoEra c) = AuxiliaryData (AlonzoEra c)

type instance Core.PParams (AlonzoEra c) = PParams (AlonzoEra c)

type instance Core.Tx (AlonzoEra c) = Tx (AlonzoEra c)

instance CC.Crypto c => UsesValue (AlonzoEra c)

instance
  (CC.Crypto c) =>
  UsesPParams (AlonzoEra c)
  where
  type
    PParamsDelta (AlonzoEra c) =
      PParamsUpdate (AlonzoEra c)

  mergePPUpdates _ = updatePParams

instance CC.Crypto c => ValidateAuxiliaryData (AlonzoEra c) where
  hashAuxiliaryData x = AuxiliaryDataHash (hashAnnotated x)
  validateAuxiliaryData = error ("NO validateAuxiliaryData yet.") -- TODO Fill this in
