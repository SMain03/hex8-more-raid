module Expr where

newtype Identifier         = Identifier String
newtype Constant           = Constant String

-- Primary Expression

data PrimaryExpr
  = PrimaryExprId     Identifier
  | PrimaryExprConst  Constant
  | StrLit            String
  | ParenExpr         Expr
  | PrimaryExprGenSel GenericSelection

data    GeneraticSelection = undefined

-- Postfix Operators

data PostfixExpr
  = PostfixPrimaryExpr        PrimaryExpr
  | PostfixExprArraySubscript PostfixExpr Expr
  | PostfixExprFuncCall       PostfixExpr (Maybe ArgExprList)
  | PostfixExprMemberDot      PostfixExpr Identifier
  | PostfixExprMemberArrow    PostfixExpr Identifier
  | PostfixExprIncr           PostfixExpr
  | PostfixExprDecr           PostfixExpr
  | PostfixCompoundLit        CompoundLit

data ArgExprList
  = ArgExprListAssExpr AssExpr
  | ArgExprList        ArgExprList AssExpr

data CompoundLit
  = CompountLit
      (Maybe StorageClassSpecifiers) TypeName BracedInitializer

data StorageClassSpecifiers
  = StorageClassSpecifiersSingle StorageClassSpecifier
  | StorageClassSpecifiers       StorageClassSpecifiers StorageClassSpecifier

-- Unary Operators

data UnaryExpr
  = UnaryPostfixExpr PostfixExpr
  | IncrUnaryExpr    UnaryExpr
  | DecrUnaryExpr    UnaryExpr
  | UnaryCastExpr    UnaryOp CastExpr
  | SizeofUnaryExpr  UnaryExpr
  | SizeofTypeName   TypeName
  | AlignofTypeName  TypeName

data UnaryOp = Ampersand | Mult | Add | Sub | Tilde | Exclam

-- Cast Operators

data CastExpr
  = CastUnaryExpr    UnaryExpr
  | TypeNameCastExpr TypeName CastExpr

-- Multiplicative Operators

data MultiplicativeExpr
  = MultiplicativeExprCastExpr CastExpr
  | MultExpr                   MultiplicativeExpr CastExpr
  | DivExpr                    MultiplicativeExpr CastExpr
  | ModExpr                    MultiplicativeExpr CastExpr

-- Additive Operators

data AdditiveExpr
  = AdditiveExprMultiplicativeExpr MultiplicativeExpr
  | AddExpr                        AdditiveExpr MultiplicativeExpr
  | SubExpr                        AdditiveExpr MultiplicativeExpr

-- Bitwise Shift Operators

data ShiftExpr
  = ShiftExprAdditiveExpr AdditiveExpr
  | LeftShiftExpr         ShiftExpr AdditiveExpr
  | RightShiftExpr        ShiftExpr AdditiveExpr

-- Relational Operators

data RelationalExpr
  = RelationalExprShiftExpr ShiftExpr
  | LTExpr                  RelationalExpr ShiftExpr
  | GTExpr                  RelationalExpr ShiftExpr
  | LEExpr                  RelationalExpr ShiftExpr
  | GEExpr                  RelationalExpr ShiftExpr

-- Equality Operators

data EqualityExpr
  = EqualityExprRelationalExpr RelationalExpr
  | EQExpr                     EqualityExpr RelationalExpr
  | NEExpr                     EqualityExpr RelationalExpr

-- Bitwise AND Operator

data AndExpr
  = AndExprEqualityExpr EqualityExpr
  | AndExpr             AndExpr EqualityExpr

-- Bitwise exclusive OR operator

data ExclusiveOrExpr
  = ExclusiveOrExprAndExpr AndExpr
  | ExclusiveOrExpr        ExclusiveOrExpr AndExpr

-- Bitwise inclusive OR operator

data InclusiveOrExpr
  = InclusiveOrExprExclusiveOrExpr ExclusiveOrExpr
  | InclusiveOrExpr                InclusiveOrExpr ExclusiveOrExpr

-- Logical AND operator

data LogicalAndExpr
  = LogicalAndExprInclusiveOrExpr InclusiveOrExpr
  | LogicalAndExpr                LogicalAndExpr InclusiveOrExpr

-- Logical OR operator

data LogicalOrExpr
  = LogicalOrExprLogicalAndExpr LogicalAndExpr
  | LogicalOrExpr               LogicalOrExpr LogicalAndExpr

-- Conditional operator

data CondExpr
  = CondExprLogicalOrExpr LogicalOrExpr
  | CondExpr LogicalOrExpr Expr CondExpr

-- Assignment operators

data AssExpr
  = AssExprCondExpr CondExpr
  | AssExpr UnaryExpr AssOp AssExpr

data AssOp
  = Eq
  | MultEq
  | DivEq
  | ModEq
  | PlusEq
  | MinusEq
  | LeftShiftEq
  | RightShiftEq
  | AmpersandEq
  | HatEq
  | PipeEq

-- Comma operator

data Expr
  = ExprAssExpr AssExpr
  | Expr        Expr AssExpr
